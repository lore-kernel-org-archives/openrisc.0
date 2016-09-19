From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Sep 2016 06:17:50 -0700
Subject: [OpenRISC] [PATCH 5/7] openrisc: Support both old (or32) and
 new (or1k) toolchain
In-Reply-To: <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
References: <1474036985-20981-1-git-send-email-shorne@gmail.com>
 <1474036985-20981-6-git-send-email-shorne@gmail.com>
 <8ef63a71-81ed-2a0c-e204-666f7fba5e4c@roeck-us.net>
 <alpine.LFD.2.20.1609191459410.2354@lianli.shorne-pla.net>
 <94c3ee37-19f7-de94-9b61-bc1c06a84d72@roeck-us.net>
 <alpine.LFD.2.20.1609191807160.2352@lianli.shorne-pla.net>
Message-ID: <e4b7075b-a1f7-74b1-ca62-4f3d2058fe97@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 09/19/2016 02:11 AM, Stafford Horne wrote:
>
>
> On Mon, 19 Sep 2016, Guenter Roeck wrote:
>
>> On 09/18/2016 11:02 PM, Stafford Horne wrote:
>>>
>>>
>>>  On Sun, 18 Sep 2016, Guenter Roeck wrote:
>>>
>>> >  Tested-by: Guenter Roeck <linux@roeck-us.net>
>>> > >  If you plan to handle openrisc going forward, it would be great if you >  could
>>> >  consider updating MAINTAINERS. The web site and git repository have been >  unreachable
>>> >  for a long time.
>>>
>>>  Thank you,
>>>  Updating maintainers was kind of on my plans, but I figured I need to
>>>  prove that I kind of know what I am doing.
>>>
>>
>> The alternative would be to mark it as Orphaned. Which, for all practical purpose,
>> would be the correct state right now.
>
> +CC The openrisc list
>
> Understood, I don't think we would want that to happen.
>
Look at the entry today:

OPENRISC ARCHITECTURE
M:      Jonas Bonn <jonas@southpole.se>
W:      http://openrisc.net
S:      Maintained
T:      git git://openrisc.net/~jonas/linux
F:      arch/openrisc/

At the very least, W: and T: are incorrect and need to be updated or removed.
Plus, apparently there is a L:, and "T: https://github.com/openrisc/linux"
might be appropriate.

Guenter


