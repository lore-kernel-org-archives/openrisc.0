From: Dmitry Safonov <dima@arista.com>
Date: Wed, 6 Nov 2019 16:27:33 +0000
Subject: [OpenRISC] [PATCH 00/50] Add log level to show_stack()
In-Reply-To: <20191106092039.GT4131@hirez.programming.kicks-ass.net>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
Message-ID: <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Peter,

On 11/6/19 9:20 AM, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 03:04:51AM +0000, Dmitry Safonov wrote:
>> Add log level argument to show_stack().
>> Done in three stages:
>> 1. Introducing show_stack_loglvl() for every architecture
>> 2. Migrating old users with an explicit log level
>> 3. Renaming show_stack_loglvl() into show_stack()
>>
>> Justification:
>> o It's a design mistake to move a business-logic decision
>>   into platform realization detail.
>> o I have currently two patches sets that would benefit from this work:
>>   Removing console_loglevel jumps in sysrq driver [1]
>>   Hung task warning before panic [2] - suggested by Tetsuo (but he
>>   probably didn't realise what it would involve).
>> o While doing (1), (2) the backtraces were adjusted to headers
>>   and other messages for each situation - so there won't be a situation
>>   when the backtrace is printed, but the headers are missing because
>>   they have lesser log level (or the reverse).
>> o As the result in (2) plays with console_loglevel for kdb are removed.
> 
> I really don't understand that word salad. Why are you doing this?
> 

Sorry, I should have tried to describe better.

I'm trying to remove external users of console_loglevel by following
reasons:
- changing console_loglevel on SMP means that unwanted messages from
other CPUs will appear (that have lower log level)
- on UMP unwanted messages may appear if the code is preempted while it
hasn't set the console_loglevel back to old
- rising console_loglevel to print wanted message(s) may not work at all
if printk() has being delayed and the console_loglevel is already set
back to old value

Sysrq driver changes console_loglevel because it needs to print message
with a specific log level (the code said userspace relies on this).
Kdb changes console_loglevel to print backtrace as the log level depends
on architecture realisation.

I also have patches in wip those needs to print backtrace with specific
loglevel (higher when it's critical, lower when it's notice and
shouldn't go to serial console).

Besides on local tests I see hits those have headers (messages like
"Backtrace: ") without an actual backtrace and the reverse - a backtrace
without a reason for it. It's quite annoying and worth addressing by
syncing headers log levels to backtraces.

Thanks,
          Dmitry
