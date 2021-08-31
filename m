From: Harshitha S <harshithasridhar172000@gmail.com>
Date: Tue, 31 Aug 2021 22:23:36 +0530
Subject: [OpenRISC] Continue OpenRISC contibution
In-Reply-To: <3353f448aa67d1d6bf61eaa37256c90d1377bb74.camel@ieee.org>
References: <CADGJwMwapL_eB_ZqKmaDsoFxCY_3qvKu=0BfdSGQZaC5GEjP1Q@mail.gmail.com>
 <YSgmu/bnzRnI7AGI@antec>
 <CADGJwMzBfYmkXPAuTuPtEmMruuTydmW1h--YQJjWTmHyiDOv6Q@mail.gmail.com>
 <CAAfxs769RLG-qTuezZYiv+Pze-sqxRAokw6pT3ecYrpn8Len4g@mail.gmail.com>
 <3353f448aa67d1d6bf61eaa37256c90d1377bb74.camel@ieee.org>
Message-ID: <CADGJwMyrBUCb8gLbDZpCgor0BTV5Ouy1N8v=2Dua7cueg=iVfg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Dan,

I have used chparam everywhere in the SBY files because an error occurred
while decoding string parameters using pycode.
Here is the small snippet where I found the error.

Code:

--pycode-begin--
cmd  = "hierarchy -top mor1kx"
cmd += " -chparam FEATURE_INSTRUCTIONCACHE %s "  %("ENABLED")
output(cmd)
--pycode-end--

Error:

[image: image.png]

How can I avoid this error? Can I use hierarchy -chparam without using
pycode?

On Tue, Aug 31, 2021 at 9:00 PM Dan <dan.gisselquist@gmail.com> wrote:

> Harshita,
>
> I would recommend replacing the "chparam" commands in your SBY files with
> "hierarchy" commands.  "chparam" forces the synthesis tool to re-read the
> design each time the command is issued, and may lead to changes that are
> inconsistent along the way.  "hierarchy" has a "-chparam" option that can
> be used to re-read the design once, setting all of the parameters in the
> design to a consistent usage.
>
> Dan
>
> On Tue, 2021-08-31 at 22:47 +0900, Stafford Horne wrote:
>
> The commit looks good, can you make a PR for it?
>
>
> On Sun, Aug 29, 2021 at 2:16 AM Harshitha S
>
>
> <
>
> harshithasridhar172000 at gmail.com
>
> > wrote:
>
>
> Hello Stafford,
>
>
> I want to start with a simple one. I have updated the Mor1kx Formal in the readme.
>
> Let me know if anything else to be included.
>
> https://github.com/Harshitha172000/mor1kx/commit/e192b83ce01cd4b467ce74fe65b2f3a7ced7a22d
>
>
>
> I will try fixing the bugs and also work on or1kx-formal. Meanwhile, I'm thinking of exploring OpenOCD/GDB
>
> for mor1kx CPU debugging but having no idea where to start. Can you guide me beginning with CPU debugging?
>
>
> -Harshitha
>
>
> On Fri, Aug 27, 2021 at 5:11 AM Stafford Horne <
>
> shorne at gmail.com
>
> > wrote:
>
>
> On Thu, Aug 26, 2021 at 10:17:17PM +0530, Harshitha S wrote:
>
> Hello,
>
>
> I'm thinking of continuing my contribution to the OpenRISC project. With my
>
> GSoC project, I have learned too many new skills and wish to keep this
>
> learning pace. I would be happy to learn and explore new skills. Please let
>
> me know what I can work upon.
>
>
> Hi Harshita,
>
>
> (CCing list)
>
>
> Glad to hear you are still interested.  I think there are always plenty of
>
> things, some things on the top of my head:
>
>   - Simple - update the mor1kx/readme.md to explain we support formal
>
>   - Medium - fix the bugs that you raised
>
>   - Bigger - or1k-formal (like riscv-formal, formally verify each instruction)
>
>
> -Stafford
>
> _______________________________________________
>
> OpenRISC mailing list
>
> OpenRISC at lists.librecores.org
>
>
> https://lists.librecores.org/listinfo/openrisc
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210831/247bc649/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image.png
Type: image/png
Size: 111049 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210831/247bc649/attachment-0001.png>
