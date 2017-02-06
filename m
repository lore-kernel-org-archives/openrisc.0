From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Tue, 7 Feb 2017 00:11:07 +0100
Subject: [OpenRISC] mor1kx
In-Reply-To: <CAF6YiZ7ZXMROWdoajkHz+B+zELig0bsWHvTPqweLr2ch-u9SXg@mail.gmail.com>
References: <DB5PR06MB130238A582A580CD9611C9DE9F400@DB5PR06MB1302.eurprd06.prod.outlook.com>
 <CAF6YiZ7ZXMROWdoajkHz+B+zELig0bsWHvTPqweLr2ch-u9SXg@mail.gmail.com>
Message-ID: <CAKaYPCMGRKi9eOt2RH5-HdzfX+fNcxtOxCojRRg2rHTUdRweZA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 6, 2017 at 10:59 PM, Julius Baxter <juliusbaxter@gmail.com>
wrote:

>
>
> On Feb 7, 2017 3:05 AM, "Kevin Irikefe" <keviniri@hotmail.co.uk> wrote:
>
> Dear Julius,
>
>
> I am a student at the University of Southampton and have a keen interest
> in microprocessor architecture. I have recently come across the mor1kx
> system and would love to modify and edit the rtl, myself, then simulate it
> on fusesoc. However, whilst searching for more information online, I have
> only managed to find how I would simulate the mor1kx-generic system.
>
>
> It would be much appreciated if you could aid me on how I would be able to
> modify and simulate the verilog?
>
>
> Kind regards,
>
>
> Kevin Irikefe
>
>
> Hi Kevin,
>
> Nice to hear about your interest in microprocessor arch and the mor1kx.
>
> I've not played with this recently, but I believe there is a contemporary
> ORPSoC-ish system using the mor1kx built with FuseSoC which exists. I've
> copied the OpenRISC list and I suppose someone who used this stuff more
> recently than I will be able to point you in the right direction for
> getting started with it.
>
> There's also usually some good help to be found in #openrisc on the
> freenode IRC network. Responses might take a day or so due to the timezones
> everyone is spread across but if you're polite and patient you'll usually
> receive an answer to any questions.
>
> Hope that helps,
>
> Julius
>
>
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
>
Hi Kevin,

I'm the author of FuseSoC. I'm well aware that the documentation is lacking
in many areas. Apologies for that. Here's a quick guide how to replace
mor1kx with your own copy, that you can make changes to

1. Create a new directory where you want to keep the cores you're working
on  (we will refer to this directory as $corelib from now on)

2. Clone the mor1kx git repository here. (cd $corelib; git clone
https://github.com/openrisc/mor1kx)

3. Edit fusesoc.conf in your workspace directory (or in
$HOME/.config/fusesoc/ if you want it for all workspaces that don't have
its own fusesoc.conf) and add the path to $corelib at the end of the line
that begin with "cores_root = ". (This will tell FuseSoC to look for
additional cores in $corelib and override cores that it has already found.
You can also use fusesoc --cores-root=/path/to/$corelib ... if you don't
want to edit config files

4. Verify that the new core is found by running fusesoc core-info mor1kx.
You should see that "Core root: " is set to $corelib/mor1kx

Now you can hack the code in $corelib/mor1kx as much as you want and run
fusesoc sim --force mor1kx-generic --lots-of-other-options to use your own
copy of mor1kx

Let me know if that works for you

//Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170207/5e91adfa/attachment.html>
