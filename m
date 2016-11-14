From: Marcus Swift <marcus_swift@crevinn.com>
Date: Mon, 14 Nov 2016 17:25:14 +0000
Subject: [OpenRISC] Nexys4DDR and OpenRISC
In-Reply-To: <62626c02-f6d5-acfa-9fb6-751d9fec76b5@wallentowitz.de>
References: <CA+2xKH_FCLWPB_r=oP5OkCgttWrzWNeaz7bE0Gk5oos4LjQJGg@mail.gmail.com>
 <62626c02-f6d5-acfa-9fb6-751d9fec76b5@wallentowitz.de>
Message-ID: <CA+2xKH8afY=dUZuJ5hChH3RD_p1j=k4KL1+aEgw-h97D+D-MaQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stefan,

Thanks for your reply, my apologies for taking so long to get back to you.
I have been trying to apply your advice, but still have some questions!

My goal is to create a Vivado project which can generate a bitstream of the
OpenRISC SOC. This will then give me a starting point so that I can
hopefully modify and add to the SOC. From examining your 'optimsoc'
repository my understanding is that this is not the route you take. You
manage to create a SOC for the Nexys4DDR in some other way that does not
use the traditional 'fusesoc build (system)' command, and no vivado project
file is produced.

***** My Question*****
Is there any way I could create a Vivado project which contains all of the
necessary components for an OpenRISC SOC on the Nexys4DDR from your
'optimsoc' repository?
-or-
How would I create a fusesoc system which generates a OpenRISC SOC on the
Nexys4DDR Vivado project?
*************************

My attempt at answering this questions is:
- Use 'andrzej-r' fusesoc system description as before.
- Replace the xilinx cores he generates using fusesoc, with cores I
generate manually in vivado as you did.
   -- This will require me to implement your 'axi2wb' adapter

If this is the best way to create a Nexys4DDR system:
- How must I edit the system top core file (
https://github.com/andrzej-r/orpsoc-cores/blob/nexys4ddr/systems/nexys4ddr/nexys4ddr_top/nexys4ddr_top.core
)
- Which Cores will I need to replace with new Cores I generate in Vivado
myself? ("nexys4ddr_clkgen", "nexys4ddr_ddr2_wb", "nexys4ddr_xadc_wb" and
"xilinx_mii_to_rmii")?
- How would I implement the "axi2wb" adapter? Can I add this to the fusesoc
system?

Please let me know if I am on the right track here! Any advice you have for
me would be very helpful! Looking forward to getting a system up and
working!

Thanks,

Marcus
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161114/1def366d/attachment.html>
