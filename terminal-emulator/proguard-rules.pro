from urllib.parse import urlparse, parse_qs
import pandas as pd
from datetime import datetime

url = "https://www.temu.com/temu-push-blind-box.html?_bg_fs=1&cp_channel=3&bbp_init_box_num_strategy=3_normal_and_1_extra&bbp_box_num=4&bbp_feeds_first_goods=601103732732021&encrypt_blx=34311f39a&mm_rid=3-CgI2WRIIalROTWUzZDAaEKKr3DCt%2BRLrfgLdiGTDgAkoAjAC&locale_override=211~en~USD&site_id=100&mmid=4694467fa7ab4ac3a951c718f3a9665aCHN3&gs_og_image=https%3A%2F%2Fimg.kwcdn.com%2Fproduct%2Ffancy%2F4ef48f57-838c-489e-a04c-380d4006fcea.jpg&msgid=211-20260129-04-O-958821776029265920-449-9BYyscCU&_p_landing=1&_x_src=sms"

parsed_url = urlparse(url)
params = parse_qs(parsed_url.query)

# Map params to fields
goods_id = params.get('bbp_feeds_first_goods', [None])[0]
msgid = params.get('msgid', [None])[0]
box_num = params.get('bbp_box_num', [1])[0]
locale = params.get('locale_override', ['~~~'])[0]
currency = locale.split('~')[-1].lower() if '~' in locale else 'usd'

# Extract date from msgid: 211-20260129-...
date_str = msgid.split('-')[1] if msgid and '-' in msgid else "20260129"
dt = datetime.strptime(date_str, "%Y%m%d")
timestamp = int(dt.timestamp())

# Prepare the new row
new_row = {
    'customer': 'cus_temu_' + (goods_id if goods_id else 'unknown'),
    'start_date': timestamp,
    'price': 'price_' + (goods_id if goods_id else 'unknown'),
    'quantity': int(box_num) if box_num else 1,
    'metadata.third_party_sub_id': msgid,
    'automatic_tax': False,
    'billing_cycle_anchor': timestamp,
    'coupon': None,
    'trial_end': None,
    'proration_behavior': 'create_prorations',
    'collection_method': 'charge_automatically',
    'default_tax_rate': None,
    'backdate_start_date': None,
    'days_until_due': None,
    'cancel_at_period_end': False,
    'add_invoice_items.0.amount': None, # Price unknown
    'add_invoice_items.0.product': 'prod_' + (goods_id if goods_id else 'unknown'),
    ' add_invoice_items.0.currency': currency # Note the leading space in the CSV header
}

# Append and save
df = pd.read_csv('billing_migration_template.csv')
# The original CSV has a column with a leading space: ' add_invoice_items.0.currency'
# Let's fix the column names to be safe or use exactly what's there.
# df.columns = df.columns.str.strip() # Better to keep as is if the user expects it.

# I'll create the row based on actual column names
new_row_final = {}
for col in df.columns:
    val = new_row.get(col)
    if val is None and col.strip() in new_row:
        val = new_row[col.strip()]
    new_row_final[col] = val

df_new = pd.DataFrame([new_row_final])
df_updated = pd.concat([df, df_new], ignore_index=True)
df_updated.to_csv('updated_billing_migration_template.csv', index=False)

print(df_updated.tail(1))


import pandas as pd

# Load the CSV to see the columns and data structure
df = pd.read_csv('billing_migration_template.csv')
print(df.head())
print(df.info())


    customer  start_date                           price  quantity metadata.third_party_sub_id  automatic_tax  billing_cycle_anchor        coupon  trial_end proration_behavior     collection_method              default_tax_rate  backdate_start_date  days_until_due cancel_at_period_end  add_invoice_items.0.amount add_invoice_items.0.product  add_invoice_items.0.currency
0  cus_xxxx1  1710937191  price_1LDGNmDK0D4Fox2RxIaXQkBp         1              subscription_1          False            1713615591        50_off        NaN  create_prorations  charge_automatically  txr_1LPcLzAWeZvbCyjpzDA4qs1l         1.705754e+09             NaN                 True                       100.0         prod_PjfC3kWS58IoOX                           usd
1  cus_xxxx2  1710937191  price_1LDGNmDK0D4Fox2RxIaXQkBp         1              subscription_2          False            1713615591        10_off        NaN               none          send_invoice  txr_1LPcLzAWeZvbCyjpzDA4qs1l         1.705754e+09            30.0                False                         NaN                         NaN                           NaN
2  cus_xxxx3  1710937191  price_1LDGNmDK0D4Fox2RxIaXQkBp         1              subscription_3          False            1713615591  black_friday        NaN  create_prorations  charge_automatically  txr_1LPcLzAWeZvbCyjpzDA4qs1l         1.705754e+09             NaN                False                         NaN                         NaN                           NaN
3  cus_xxxx4  1710937191  price_1LDGNmDK0D4Fox2RxIaXQkBp         1              subscription_4          False            1713615591           NaN        NaN  create_prorations  charge_automatically                           NaN                  NaN             NaN                  NaN                         NaN                         NaN                           NaN
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 4 entries, 0 to 3
Data columns (total 18 columns):
 #   Column                         Non-Null Count  Dtype  
---  ------                         --------------  -----  
 0   customer                       4 non-null      object 
 1   start_date                     4 non-null      int64  
 2   price                          4 non-null      object 
 3   quantity                       4 non-null      int64  
 4   metadata.third_party_sub_id    4 non-null      object 
 5   automatic_tax                  4 non-null      bool   
 6   billing_cycle_anchor           4 non-null      int64  
 7   coupon                         3 non-null      object 
 8   trial_end                      0 non-null      float64
 9   proration_behavior             4 non-null      object 
 10  collection_method              4 non-null      object 
 11  default_tax_rate               3 non-null      object 
 12  backdate_start_date            3 non-null      float64
 13  days_until_due                 1 non-null      float64
 14  cancel_at_period_end           3 non-null      object 
 15  add_invoice_items.0.amount     1 non-null      float64
 16  add_invoice_items.0.product    1 non-null      object 
 17   add_invoice_items.0.currency  1 non-null      object 
dtypes: bool(1), float64(4), int64(3), object(10)
memory usage: 676.0+ bytes
None

from urllib.parse import urlparse, parse_qs
import pandas as pd
from datetime import datetime

url = "https://www.temu.com/temu-push-blind-box.html?_bg_fs=1&cp_channel=3&bbp_init_box_num_strategy=3_normal_and_1_extra&bbp_box_num=4&bbp_feeds_first_goods=601103732732021&encrypt_blx=34311f39a&mm_rid=3-CgI2WRIIalROTWUzZDAaEKKr3DCt%2BRLrfgLdiGTDgAkoAjAC&locale_override=211~en~USD&site_id=100&mmid=4694467fa7ab4ac3a951c718f3a9665aCHN3&gs_og_image=https%3A%2F%2Fimg.kwcdn.com%2Fproduct%2Ffancy%2F4ef48f57-838c-489e-a04c-380d4006fcea.jpg&msgid=211-20260129-04-O-958821776029265920-449-9BYyscCU&_p_landing=1&_x_src=sms"

parsed_url = urlparse(url)
params = parse_qs(parsed_url.query)

# Map params to fields
goods_id = params.get('bbp_feeds_first_goods', [None])[0]
msgid = params.get('msgid', [None])[0]
box_num = params.get('bbp_box_num', [1])[0]
locale = params.get('locale_override', ['~~~'])[0]
currency = locale.split('~')[-1].lower() if '~' in locale else 'usd'

# Extract date from msgid: 211-20260129-...
date_str = msgid.split('-')[1] if msgid and '-' in msgid else "20260129"
dt = datetime.strptime(date_str, "%Y%m%d")
timestamp = int(dt.timestamp())

# Prepare the new row
new_row = {
    'customer': 'cus_temu_' + (goods_id if goods_id else 'unknown'),
    'start_date': timestamp,
    'price': 'price_' + (goods_id if goods_id else 'unknown'),
    'quantity': int(box_num) if box_num else 1,
    'metadata.third_party_sub_id': msgid,
    'automatic_tax': False,
    'billing_cycle_anchor': timestamp,
    'coupon': None,
    'trial_end': None,
    'proration_behavior': 'create_prorations',
    'collection_method': 'charge_automatically',
    'default_tax_rate': None,
    'backdate_start_date': None,
    'days_until_due': None,
    'cancel_at_period_end': False,
    'add_invoice_items.0.amount': None, # Price unknown
    'add_invoice_items.0.product': 'prod_' + (goods_id if goods_id else 'unknown'),
    ' add_invoice_items.0.currency': currency # Note the leading space in the CSV header
}

# Append and save
df = pd.read_csv('billing_migration_template.csv')
# The original CSV has a column with a leading space: ' add_invoice_items.0.currency'
# Let's fix the column names to be safe or use exactly what's there.
# df.columns = df.columns.str.strip() # Better to keep as is if the user expects it.

# I'll create the row based on actual column names
new_row_final = {}
for col in df.columns:
    val = new_row.get(col)
    if val is None and col.strip() in new_row:
        val = new_row[col.strip()]
    new_row_final[col] = val

df_new = pd.DataFrame([new_row_final])
df_updated = pd.concat([df, df_new], ignore_index=True)
df_updated.to_csv('updated_billing_migration_template.csv', index=False)

print(df_updated.tail(1))


                   customer  start_date                  price  quantity                        metadata.third_party_sub_id  automatic_tax  billing_cycle_anchor coupon trial_end proration_behavior     collection_method default_tax_rate backdate_start_date days_until_due cancel_at_period_end add_invoice_items.0.amount add_invoice_items.0.product  add_invoice_items.0.currency
4  cus_temu_601103732732021  1769644800  price_601103732732021         4  211-20260129-04-O-958821776029265920-449-9BYyscCU          False            1769644800   None      None  create_prorations  charge_automatically             None                None           None                False                       None        prod_601103732732021                           usd

# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/fornwall/lib/android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
