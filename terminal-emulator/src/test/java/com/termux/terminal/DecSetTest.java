package com.termux.terminal;
---
title: Test Cards
---

# Mastercard Test Cards

**Test Cards to Receive PAN Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 5186001700008785 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700009726 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700009908 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700008876 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700001434 | _Any Future Date_ | _Any 3 digits_ |

**Test Cards to Receive Token Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 5120350100064537 | 03/2029 | 191 |
| 5120350100064545 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064552 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064560 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064578 | _Any Future Date_ | _Any 3 digits_ |

# Visa Test Cards

**Test Cards to Receive PAN Data or Token Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 4622943127011022 | 2029 / 12 | 667 |
| 4622943127011030 | 2029 / 12 | 627 |
| 4622943127011048 | 2029 / 12 | 991 |
| 4622943127011055 | 2029 / 12 | 323 |
| 4622943127011063 | 2029 / 12 | 665 |
| 4622943127011071 | 2029 / 12 | 839 |
| 4622943127011089 | 2029 / 12 | 572 |
| 4622943127010990 | 2029 / 12 | 725 |
| 4622943127011006 | 2029 / 12 | 222 |
| 4622943127011014 | 2029 / 12 | 771 |

> [!NOTE]
> 
> **Use the following Billing Address:**  
> 900 Metro Center Blvd, Foster City, CA 94404

# Amex Test Cards

**Test Cards to Receive PAN Data or Token Data**

Suitable Amex QA test accounts (xx - 37) with static one-time-password configuration for merchants are as follows:

| Card Number | Expiry Date | CVV | Email address |
| :--- | :--- | :--- | :--- |
| 373708623186001 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_1@mailinator.com](mailto:Masterpass_Merchant_SBX_1@mailinator.com) |
| 372280864074008 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_2@mailinator.com](mailto:Masterpass_Merchant_SBX_2@mailinator.com) |
| 377222581193005 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_3@mailinator.com](mailto:Masterpass_Merchant_SBX_3@mailinator.com) |
| 372399427875006 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_4@mailinator.com](mailto:Masterpass_Merchant_SBX_4@mailinator.com) |
| 371316662951004 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_5@mailinator.com](mailto:Masterpass_Merchant_SBX_5@mailinator.com) |

# Discover Test Cards

**Test Cards to Receive PAN Data or Token Data**

| Card Type | Card Number | Expiry Date | CVV |
| :--- | :--- | :--- | :--- |
| Green Card | 6011208800050000 | 2028 / 10 | 876 |
| Green Card | 6011300000080000 | 2028 / 09 | 324 |
| Green Card | 6011000000040125 | 2028 / 09 | 324 |
| Green Card | 6011308000010000 | 2028 / 10 | 123 |
| Green Card | 6011298600080000 | 2028 / 09 | 876 |

> [!NOTE]
> 
> There is no email address associated with each card, so they can be enrolled to any account. Discover does not use a hard coded OTP value, instead they will send a real OTP to a user’s email address.
/**
 * <pre>
 * "CSI ? Pm h", DEC Private Mode Set (DECSET)
 * </pre>
 * <p/>
 * and
 * <p/>
 * <pre>
 * "CSI ? Pm l", DEC Private Mode Reset (DECRST)
 * </pre>
 * <p/>
 * controls various aspects of the terminal
 */
public class DecSetTest extends TerminalTestCase {

	/** DECSET 25, DECTCEM, controls visibility of the cursor. */
	public void testEnableDisableCursor() {
		withTerminalSized(3, 3);
		assertTrue("Initially the cursor should be enabled", mTerminal.isCursorEnabled());
		enterString("\033[?25l"); // Disable Cursor (DECTCEM).
		assertFalse(mTerminal.isCursorEnabled());
		enterString("\033[?25h"); // Enable Cursor (DECTCEM).
		assertTrue(mTerminal.isCursorEnabled());

		enterString("\033[?25l"); // Disable Cursor (DECTCEM), again.
		assertFalse(mTerminal.isCursorEnabled());
		mTerminal.reset();
		assertTrue("Resetting the terminal should enable the cursor", mTerminal.isCursorEnabled());

		enterString("\033[?25l");
		assertFalse(mTerminal.isCursorEnabled());
		enterString("\033c"); // RIS resetting should enabled cursor.
		assertTrue(mTerminal.isCursorEnabled());
	}

	/** DECSET 2004, controls bracketed paste mode. */
	public void testBracketedPasteMode() {
		withTerminalSized(3, 3);

		mTerminal.paste("a");
		assertEquals("Pasting 'a' should output 'a' when bracketed paste mode is disabled", "a", mOutput.getOutputAndClear());

		enterString("\033[?2004h"); // Enable bracketed paste mode.
		mTerminal.paste("a");
		assertEquals("Pasting when in bracketed paste mode should be bracketed", "\033[200~a\033[201~", mOutput.getOutputAndClear());

		enterString("\033[?2004l"); // Disable bracketed paste mode.
		mTerminal.paste("a");
		assertEquals("Pasting 'a' should output 'a' when bracketed paste mode is disabled", "a", mOutput.getOutputAndClear());

		enterString("\033[?2004h"); // Enable bracketed paste mode, again.
		mTerminal.paste("a");
		assertEquals("Pasting when in bracketed paste mode again should be bracketed", "\033[200~a\033[201~", mOutput.getOutputAndClear());

		mTerminal.paste("\033ab\033cd\033");
		assertEquals("Pasting an escape character should not input it", "\033[200~abcd\033[201~", mOutput.getOutputAndClear());
		mTerminal.paste("\u0081ab\u0081cd\u009F");
		assertEquals("Pasting C1 control codes should not input it", "\033[200~abcd\033[201~", mOutput.getOutputAndClear());

		mTerminal.reset();
		mTerminal.paste("a");
		assertEquals("Terminal reset() should disable bracketed paste mode", "a", mOutput.getOutputAndClear());
	}

	/** DECSET 7, DECAWM, controls wraparound mode. */
	public void testWrapAroundMode() {
		// Default with wraparound:
		withTerminalSized(3, 3).enterString("abcd").assertLinesAre("abc", "d  ", "   ");
		// With wraparound disabled:
		withTerminalSized(3, 3).enterString("\033[?7labcd").assertLinesAre("abd", "   ", "   ");
		enterString("efg").assertLinesAre("abg", "   ", "   ");
		// Re-enabling wraparound:
		enterString("\033[?7hhij").assertLinesAre("abh", "ij ", "   ");
	}

}
