From: Stafford Horne <shorne@gmail.com>
Date: Thu, 2 Sep 2021 06:06:03 +0900
Subject: [OpenRISC] Continue OpenRISC contibution
In-Reply-To: <CADGJwMzCa_u2+V3Tu-pp92GgxubwiU0HQo0Dy5G3b0sAO2xzFw@mail.gmail.com>
References: <CADGJwMwapL_eB_ZqKmaDsoFxCY_3qvKu=0BfdSGQZaC5GEjP1Q@mail.gmail.com>
 <YSgmu/bnzRnI7AGI@antec>
 <CADGJwMzBfYmkXPAuTuPtEmMruuTydmW1h--YQJjWTmHyiDOv6Q@mail.gmail.com>
 <CAAfxs74_+W_dTa-yjx=+jJ3fm9R1hzS1_QVWJTPvn3fEgXaEng@mail.gmail.com>
 <CADGJwMzCa_u2+V3Tu-pp92GgxubwiU0HQo0Dy5G3b0sAO2xzFw@mail.gmail.com>
Message-ID: <CAAfxs77m594YDv0bbhY98Ye10F0jWyROqrDpCheq5Azk7Gg0aA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Which model of spartan 7 FPGA board do you have?  Lets figure out if
it has support for a fusesoc soc.

Here is a list of some of the boards supported.
https://github.com/openrisc/orpsoc-cores/tree/master/systems

Some of these have been moved out to independent projects now:
  - https://github.com/olofk/de0_nano
  - https://github.com/stffrdhrn/mor1kx-generic  (just for simulation
not fpga boards)

It is preferred for the systems to be in their own repositories now.

If your board is not here then we can search for fusesoc support, if
nothing is found you can work on bringing up fusesoc on it.

On Thu, Sep 2, 2021 at 1:17 AM Harshitha S
<harshithasridhar172000@gmail.com> wrote:
>
> Thanks for the info, I will go through these links.
>
> Yes, I have Spartan 7 FPGA board.
>
> On Wed, 1 Sep, 2021, 6:56 PM Stafford Horne, <shorne@gmail.com> wrote:
>>
>> In terms of debugging I put this together a while back for how to
>> setup and use the OpenOCD / GDB debug environment for openrisc.
>> https://github.com/openrisc/tutorials/blob/master/docs/Debugging.md
>>
>> This assumes you have an FPGA board like the de0 nano and are able to
>> program one of the fusesoc mor1kx with adv_debug_sys bitstreams onto
>> it.  All that can be done via fusesoc which wraps the process.  There
>> are documents about doing that on the web, also one here:
>> https://github.com/openrisc/tutorials/tree/master/de0_nano
>>
>> Do you have an FPGA board you can use?
>>
>> -Stafford
>>
>> On Sun, Aug 29, 2021 at 2:16 AM Harshitha S
>> <harshithasridhar172000@gmail.com> wrote:
>> >
>> > Hello Stafford,
>> >
>> > I want to start with a simple one. I have updated the Mor1kx Formal in the readme.
>> > Let me know if anything else to be included.
>> > https://github.com/Harshitha172000/mor1kx/commit/e192b83ce01cd4b467ce74fe65b2f3a7ced7a22d
>> >
>> > I will try fixing the bugs and also work on or1kx-formal. Meanwhile, I'm thinking of exploring OpenOCD/GDB
>> > for mor1kx CPU debugging but having no idea where to start. Can you guide me beginning with CPU debugging?
>> >
>> > -Harshitha
>> >
>> > On Fri, Aug 27, 2021 at 5:11 AM Stafford Horne <shorne@gmail.com> wrote:
>> >>
>> >> On Thu, Aug 26, 2021 at 10:17:17PM +0530, Harshitha S wrote:
>> >> > Hello,
>> >> >
>> >> > I'm thinking of continuing my contribution to the OpenRISC project. With my
>> >> > GSoC project, I have learned too many new skills and wish to keep this
>> >> > learning pace. I would be happy to learn and explore new skills. Please let
>> >> > me know what I can work upon.
>> >>
>> >> Hi Harshita,
>> >>
>> >> (CCing list)
>> >>
>> >> Glad to hear you are still interested.  I think there are always plenty of
>> >> things, some things on the top of my head:
>> >>   - Simple - update the mor1kx/readme.md to explain we support formal
>> >>   - Medium - fix the bugs that you raised
>> >>   - Bigger - or1k-formal (like riscv-formal, formally verify each instruction)
>> >>
>> >> -Stafford
