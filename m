From: Jonas Bonn <jonas@southpole.se>
Date: Mon, 2 Jan 2017 11:34:32 +0100
Subject: [OpenRISC] [PATCH 0/3] Openrisc 4.10 fixes
In-Reply-To: <20161231225059.GC2777@lianli.shorne-pla.net>
References: <cover.1483184705.git.shorne@gmail.com>
 <5edddd32-2a31-8b52-adfa-f5edae1fc227@southpole.se>
 <20161231225059.GC2777@lianli.shorne-pla.net>
Message-ID: <efa24779-b5a5-718a-8133-4ce24a010ab1@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 12/31/2016 11:50 PM, Stafford Horne wrote:
> Hi Jonas,
>
> On Sat, Dec 31, 2016 at 03:10:37PM +0100, Jonas Bonn wrote:
>> Hi Stafford,
>>
>> Post-merge window patches should  be bug fixes, only.  Patch 1/3 probably
>> qualifies, but the others are far too trivial to be pushing now.  Just put
>> them on your 4.11 branch.
> Thanks, for some reason I thought minor changes like this were ok too.
> I will only push the one change in this case.  The rest will go to my
> 4.11 queue, which I'll send for review in the next few days.
Actually, it's not even bug-fixes, just fixes for regressions. Patch 1 
fixes something which has never worked so it's not even a regression... 
just hold everything for 4.11.  Get your 4.11 branch ready and pushed to 
-next now and then start working on stuff for 4.12.

>
> That brings up a question, Do you want to stay in the MAINTAINERS file?
> I noticed sometimes you dont get around to review, but often when you do
> the reviews are helpful like this one.
Yes, keep me in the MAINTAINERS file.

Thanks,
Jonas


