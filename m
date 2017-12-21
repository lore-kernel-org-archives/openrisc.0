From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Wed, 20 Dec 2017 21:40:10 -0500
Subject: [OpenRISC] [PATCH v3 1/4] reggroups: Add test and docs for
 `info reg $reggroup` feature
In-Reply-To: <837etiptz2.fsf@gnu.org>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-2-shorne@gmail.com> <837etiptz2.fsf@gnu.org>
Message-ID: <596161e11663add8b95ca70dd1f8f12b@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-12-19 11:23, Eli Zaretskii wrote:
>> From: Stafford Horne <shorne@gmail.com>
>> Cc: Openrisc <openrisc@lists.librecores.org>,	Stafford Horne 
>> <shorne@gmail.com>
>> Date: Tue, 19 Dec 2017 23:22:54 +0900
>> 
>> Until now this feature has existed but was not documented.  Adding 
>> docs
>> and tests.
> 
> Thanks!
> 
>> + at item info registers @var{reggroup} @dots{}
>> +Print the name and value of the registers in each of the specified
>> + at var{reggroup}.  The @var{reggoup} can be any of those returned by
> 
> Please use "@var{reggroup}s", with the trailing "s", otherwise this is
> not correct English.
> 
>> + at code{maint print reggroups}.
> 
> Please add here a cross-reference to the node where "maint print
> reggroups" is described.

Is it ok for a non-maint command to refer to a maint command?  AFAIK, we 
don't expect an average user to have to use maintenance commands when 
using GDB.  So maybe "maint print reggroups" should be promoted to a 
non-maint command (e.g. info register-groups)?

Simon
