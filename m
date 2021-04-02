From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 2 Apr 2021 17:33:06 +0200
Subject: [OpenRISC] [PATCH v3 01/17] cmdline: Add generic function to
 build command line.
In-Reply-To: <20210330172714.GR109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
Message-ID: <9c74d82f-f58f-1ccb-bf22-8eb02a4cd55d@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 30/03/2021 à 19:27, Daniel Walker a écrit :
> On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3:
>> - Addressed comments from Will
>> - Added capability to have src == dst
>> ---
>>   include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 include/linux/cmdline.h
>>
>> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>> new file mode 100644
>> index 000000000000..dea87edd41be
>> --- /dev/null
>> +++ b/include/linux/cmdline.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CMDLINE_H
>> +#define _LINUX_CMDLINE_H
>> +
>> +#include <linux/string.h>
>> +
>> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
>> +#ifndef cmdline_strlcat
>> +#define cmdline_strlcat strlcat
>> +#endif
>> +
>> +/*
>> + * This function will append or prepend a builtin command line to the command
>> + * line provided by the bootloader. Kconfig options can be used to alter
>> + * the behavior of this builtin command line.
>> + * @dst: The destination of the final appended/prepended string.
>> + * @src: The starting string or NULL if there isn't one.
>> + * @len: the length of dest buffer.
>> + */
> 
> Append or prepend ? Cisco requires both at the same time. This is why my
> implementation provides both. I can't use this with both at once.
> 

I think it can be added as a second step if dimmed necessary. The feeling I have from all the 
discussion is that it's not what people from the community are looking for at the moment.

Anyway, once all architectures are moved to generic handling, I believe it is then easier to split 
CONFIG_CMDLINE in two configuration items in order to provide both appending and prepending at the 
same time.

I see some concerns about risk of double changes, but I have focussed in changing as little as 
possible the existing configuration items, in order to minimise that.
