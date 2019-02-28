From: Stafford Horne <shorne@gmail.com>
Date: Fri, 1 Mar 2019 08:33:17 +0900
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <D036467FCCAF4D23A7566ED09E17825B@BAndViG>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
 <37FCFC974D464083BD1071538AD0EAFD@BAndViG>
 <CAF6YiZ6j=GbTG_G-q2=KYf6Nc-kACgGvxbtRMBjaRdQd8oi08A@mail.gmail.com>
 <20190201215417.GY3235@lianli.shorne-pla.net>
 <D036467FCCAF4D23A7566ED09E17825B@BAndViG>
Message-ID: <CAAfxs74D0J+Gv8dm+8CvYAQtfqUcajUgG4KEb5yKecGmH3aYYA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,



On Wed, Feb 27, 2019, 4:25 AM BAndViG <bandvig@mail.ru> wrote:

> Hi all
>
> I've created MAROCCHINO new repo under my GitHub account
> (https://github.com/bandvig/or1k_marocchino) as a demo version.
>

This looks good.

Pay attention that monitors still have "mor1kx_" prefix and
> or1k_marocchino_cpu
> instance still called "mor1kx_cpu" to maintain compatibility with current
> verification infrastructure.
>

I think we can change this now. As long as we have:

bench <https://github.com/bandvig/or1k_marocchino/tree/master/bench>/verilog
<https://github.com/bandvig/or1k_marocchino/tree/master/bench/verilog>/
mor1kx_monitor

We can define internals as we like.  Before we we're trying to share so we
needed to use the same name.


Please, make comments and proposals.
>

Some comments.
 - let's put a style guide in the readme
 - can we split modules to separate files? I.e. or1k_marocchino_execute.v
and or1k_marocchino_oman.v have some interesting modules I think would make
sense to be on their own for.  Not everything needs to be split , but at
least each execution unit and the RAT modules.
  - I created a diagram on the pipeline dependencies. You then explained
some things  more clearly.  I'll try to put it on the wiki or in the repo.

I'm planning to continue development in the repo as its structure will be
> approved. Btw, I'm not sure that it should be forked into OR organization.
> I
> think it would be clearer to create new repo and fill it. I could do that
> by
> myself If I've got write access to OR organization account (not sure). Or
> anybody welcome to do that.
>

I think having it the openrisc org repo would be good.  Let me see if I can
clone it in and give you access.  If not I'll ask for help.

-stafford


> WBR
> Andrey
>
>
> From: Stafford Horne
> Sent: Saturday, February 02, 2019 12:54 AM
> To: Julius Baxter
> Cc: BAndViG ; Olof Kindgren ; Openrisc ; Philipp Wagner ; Stefan
> Wallentowitz
> Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
>
> I changed the name of the instance to mor1kx_cpu to be able to use the
> mor1x_monitor without any changes when switching core implementations
> during
> testing.
>
> I think the right way to do monitoring will be to use the new traceport_*
> signals to monitor processor execution (there is already an implementation
> of
> monitor that does that).  The traceport implementation will not require
> inspecting internal signals as is done with the current mor1kx_monitor.
>
> Its here:
>   bench/verilog/mor1kx_monitor.v           - traditional monitor
>   bench/verilog/mor1kx_traceport_monitor.v - traceport_based monitor
> ...
>
> -Stafford
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190301/084a9083/attachment.html>
