From: Nancy Chauhan <nancychn1@gmail.com>
Date: Wed, 3 Jul 2019 10:32:24 +0530
Subject: [OpenRISC] [GSoC 2019] Coding Phase 2 : Continuous Integration
 for Hardware Projects on LibreCores CI (Nancy Chauhan)
In-Reply-To: <CAKaYPCPNiGT2m+9cviPFui_Dzbo1QOnQviB0s+foa093rTwGKw@mail.gmail.com>
References: <CAF69GoqLtjD3jySOto4Fu3N9PRb1Ji5CyNHK7ScYvv+bOeiYKg@mail.gmail.com>
 <CAAfxs77GYaDHJL-qLmQqTqrpAjvws=8Q52qS7eYyX52NFc9z3g@mail.gmail.com>
 <CAKaYPCPNiGT2m+9cviPFui_Dzbo1QOnQviB0s+foa093rTwGKw@mail.gmail.com>
Message-ID: <CAF69Gope9f3x7-26s3L5fMiK8W2XFqR4GGW9w-BS7gX9o-PeeQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jul 3, 2019 at 1:40 AM Olof Kindgren <olof.kindgren@gmail.com>
wrote:

>
>
> On Tue, Jul 2, 2019 at 1:04 AM Stafford Horne <shorne@gmail.com> wrote:
>
>> Hello,
>>
>> On Mon, Jul 1, 2019, 9:22 PM Nancy Chauhan <nancychn1@gmail.com> wrote:
>>
>>> Hello all,
>>>
>>> This mail is to summarize the plan for Coding phase 2 of GSoC 2019. I
>>> will be working to Create CI for Yosys synthesis
>>> <http://www.clifford.at/yosys/>required for monitoring resource usages
>>> in mor1kx <https://github.com/Nancy-Chauhan/mor1kx> and also might
>>> further extend CI for Ysoys synthesis if possible for place and route ( https://github.com/YosysHQ/arachne-pnr
>>> ).
>>>
>>
>> Probably we want nextpnr here.
>> https://github.com/YosysHQ/nextpnr
>>
> Hi,

As far as I have seen https://github.com/olofk/serv/blob/master/serv.core,
https://github.com/olofk/serv/blob/master/servant.core *example project
using fusesoc and yosys*, I realized we might have to do changes in
mor1kx.core https://github.com/openrisc/mor1kx/blob/master/mor1kx.core#L79
and may also have to include target boards the repository. Can you further
clarify on this and guide me further.

>
> I tried to do my part here and just pushed an edalize patch to only run
> synthesis in the icestorm backend by setting pnr to none.
>
> Tested it on my serv CPU with fusesoc run --target=tinyfpga_bx servant
> --pnr=none
>

And also we can try this first.

Hope this helps
>
> //Olof
>
>
>>
>>
>> The plan will be reached to work even on Creating CI for OpenOCD/GDB  for
>>> CPU pipeline debugging in mor1kx  and extending Jenkinsfile (
>>> https://github.com/openrisc/mor1kx/pull/84 ) in mor1kx to make Ysoys
>>> and OpenOCD/GDB part of the build pipeline. It can be added to
>>> ci.librecores.org so that Pull request builder runs for the repository
>>> mor1kx .
>>> We can later  Detach reusable logic of mor1kx to https://github.com/librecores/librecores-pipeline-lib
>>> .
>>>
>>> The question I have is whether should we keep all these new additions in
>>> current Travis flow ( https://github.com/openrisc/mor1kx/blob/master/.travis.yml
>>> ) also ?
>>>
>>>
>> I think we can replace Travis when
>>   1. We have a new build status badge for Jenkins in the readme.
>>   2. Jenkins is integrated and performs all of the same checks for pull
>> requests.
>>   3. (Nice to have) Jenkins can be as fast/faster than Travis i.e. finish
>> within 5 minutes
>>
>>
>>> Thank you ,
>>> Nancy Chauhan
>>>
>>> Chats on : https://gitter.im/librecores/librecores-ci
>>>
>> _______________________________________________
>> OpenRISC mailing list
>> OpenRISC at lists.librecores.org
>> https://lists.librecores.org/listinfo/openrisc
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190703/09c157fe/attachment.html>
