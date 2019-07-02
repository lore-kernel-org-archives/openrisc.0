From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Tue, 2 Jul 2019 22:10:00 +0200
Subject: [OpenRISC] [GSoC 2019] Coding Phase 2 : Continuous Integration
 for Hardware Projects on LibreCores CI (Nancy Chauhan)
In-Reply-To: <CAAfxs77GYaDHJL-qLmQqTqrpAjvws=8Q52qS7eYyX52NFc9z3g@mail.gmail.com>
References: <CAF69GoqLtjD3jySOto4Fu3N9PRb1Ji5CyNHK7ScYvv+bOeiYKg@mail.gmail.com>
 <CAAfxs77GYaDHJL-qLmQqTqrpAjvws=8Q52qS7eYyX52NFc9z3g@mail.gmail.com>
Message-ID: <CAKaYPCPNiGT2m+9cviPFui_Dzbo1QOnQviB0s+foa093rTwGKw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jul 2, 2019 at 1:04 AM Stafford Horne <shorne@gmail.com> wrote:

> Hello,
>
> On Mon, Jul 1, 2019, 9:22 PM Nancy Chauhan <nancychn1@gmail.com> wrote:
>
>> Hello all,
>>
>> This mail is to summarize the plan for Coding phase 2 of GSoC 2019. I
>> will be working to Create CI for Yosys synthesis
>> <http://www.clifford.at/yosys/>required for monitoring resource usages
>> in mor1kx <https://github.com/Nancy-Chauhan/mor1kx> and also might
>> further extend CI for Ysoys synthesis if possible for place and route ( https://github.com/YosysHQ/arachne-pnr
>> ).
>>
>
> Probably we want nextpnr here.
> https://github.com/YosysHQ/nextpnr
>

I tried to do my part here and just pushed an edalize patch to only run
synthesis in the icestorm backend by setting pnr to none.

Tested it on my serv CPU with fusesoc run --target=tinyfpga_bx servant
--pnr=none

Hope this helps

//Olof


>
>
> The plan will be reached to work even on Creating CI for OpenOCD/GDB  for
>> CPU pipeline debugging in mor1kx  and extending Jenkinsfile (
>> https://github.com/openrisc/mor1kx/pull/84 ) in mor1kx to make Ysoys and
>> OpenOCD/GDB part of the build pipeline. It can be added to
>> ci.librecores.org so that Pull request builder runs for the repository
>> mor1kx .
>> We can later  Detach reusable logic of mor1kx to https://github.com/librecores/librecores-pipeline-lib
>> .
>>
>> The question I have is whether should we keep all these new additions in
>> current Travis flow ( https://github.com/openrisc/mor1kx/blob/master/.travis.yml
>> ) also ?
>>
>>
> I think we can replace Travis when
>   1. We have a new build status badge for Jenkins in the readme.
>   2. Jenkins is integrated and performs all of the same checks for pull
> requests.
>   3. (Nice to have) Jenkins can be as fast/faster than Travis i.e. finish
> within 5 minutes
>
>
>> Thank you ,
>> Nancy Chauhan
>>
>> Chats on : https://gitter.im/librecores/librecores-ci
>>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190702/cbb19846/attachment.html>
