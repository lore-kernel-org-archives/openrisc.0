From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Wed, 5 May 2021 09:51:43 +0200
Subject: [OpenRISC] [PATCH v2 0/2] OpenRISC support for cmodel=large
In-Reply-To: <20210505063004.GT3288043@lianli.shorne-pla.net>
References: <20210505063004.GT3288043@lianli.shorne-pla.net>
Message-ID: <0E376E20-5570-4914-A816-679D77FB1E24@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Stafford, All,

> Il giorno 5 mag 2021, alle ore 08:30, Stafford Horne <shorne@gmail.com> ha scritto:
> 
> ﻿On Mon, May 03, 2021 at 12:34:22PM +0200, Giulio Benetti wrote:
>> Hi Stafford, All,
>> 
>> I've backported this patchset for Buildroot to versions:
>> - 9.3.0
>> - 10.3.0
>> 
>> Does it make sense to send them? I don't know if those version will have
>> minor versions where these backported patches can be applied.
> 
> Do you mean for me/you to send the backported GCC patches for GCC or buildroot?
I mean for GCC, I’ve already sent them for buildroot:
https://patchwork.ozlabs.org/project/buildroot/list/?series=241844

> 
> I don't need backported versions of the toolchains and usually work off the
> latest release/master.  If someone wants them let me know.
I was asking to know if newer minor versions of
binutils and gcc will be released. If yes I could
send your back ported patches here in the 2 mailing lists(binutils and gcc ones).

Giulio Benetti

> 
> -Stafford
> 
>> Best regards
>> -- 
>> Giulio Benetti
>> Benetti Engineering sas
>> 
>>> On 5/1/21 11:11 PM, Stafford Horne wrote:
>>> Changes from v1:
>>>  - Added patch to enabled cmodle=large on crtstuff
>>> 
>>> This series fixes some bugs found when linking large binaries, both in buildroot
>>> and glibc testing.
>>> 
>>> Stafford Horne (2):
>>>   or1k: Add mcmodel option to handle large GOTs
>>>   or1k: Use cmodel=large when building crtstuff
>>> 
>>>  gcc/config/or1k/or1k-opts.h   | 30 ++++++++++++++++++++++++++++++
>>>  gcc/config/or1k/or1k.c        | 11 +++++++++--
>>>  gcc/config/or1k/or1k.h        |  7 +++++++
>>>  gcc/config/or1k/or1k.opt      | 19 +++++++++++++++++++
>>>  gcc/doc/invoke.texi           | 12 +++++++++++-
>>>  libgcc/config.host            |  4 ++--
>>>  libgcc/config/or1k/t-crtstuff |  2 ++
>>>  7 files changed, 80 insertions(+), 5 deletions(-)
>>>  create mode 100644 gcc/config/or1k/or1k-opts.h
>>>  create mode 100644 libgcc/config/or1k/t-crtstuff
>>> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210505/2265ec9c/attachment.htm>
