From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Thu, 2 Sep 2021 21:49:12 +0300
Subject: [OpenRISC] Reporting the bugs in MOR1KX processor
In-Reply-To: <CAPV5DU64Hja40XHgvUz2ph7gcBtNWinUNH633vCfxH7vxEvshA@mail.gmail.com>
References: <CAPV5DU64Hja40XHgvUz2ph7gcBtNWinUNH633vCfxH7vxEvshA@mail.gmail.com>
Message-ID: <CADzBsGPS1McirO2W_HRJxDr94DCh-63bEqCfF1ABjPTYPEH3+A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 2, 2021 at 8:53 PM Jeyavijayan Rajendran <jeyavijayan@tamu.edu>
wrote:

> Dear Developers of the MOR1KX processor,
>
> We are research teams from Texas A&M University and TU Darmstadt. We
> found the following bugs in your MOR1KX processor design (
> https://github.com/openrisc/mor1kx
> <https://urldefense.com/v3/__https://github.com/openrisc/mor1kx__;!!KwNVnqRv!SNshfFgKzp1a7X2JYV-4kru80LEyB-7pSHRNT2CfnwuMzUMLkGpkd-6OXtBiVlQn4uw$>
> ).
>
> We intend to get CVE listing numbers for all these bugs to include in our
> research paper. Hence, we would like to disclose these bugs to you before
> we request CVE IDs.
>
> Please respond to us by *10th Sept 2021, 11:59 PM UTC *with your
> acknowledgment of the bugs.
>
> In case you are not authorized to comment on the bugs, please connect us
> with the right contact person or channel for this matter.
>
> Also, let us know if your processor design is one of the CNA-covered
> products (https://cve.mitre.org/cve/cna.html
> <https://urldefense.com/v3/__https://cve.mitre.org/cve/cna.html__;!!KwNVnqRv!SNshfFgKzp1a7X2JYV-4kru80LEyB-7pSHRNT2CfnwuMzUMLkGpkd-6OXtBi93tT1sQ$>)
> so that we can include the same in our CVE listing.
>
>
> Vendor of the product(s): openrisc
>
>
> Bug 1:
>
> Bug: The carry flag is incorrectly implemented for subtract instructions.
>
> Location:  mor1kx_execute_alu.v (
> https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_execute_alu.v
> <https://urldefense.com/v3/__https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_execute_alu.v__;!!KwNVnqRv!SNshfFgKzp1a7X2JYV-4kru80LEyB-7pSHRNT2CfnwuMzUMLkGpkd-6OXtBi4Qmr_iI$>
> ).
>
> Triggering input:
>
> //set r1=00020000 and r3=00002000
>
>      l.sub    r4,r1,r3
>
> Expected output:
>
>                Carry flag = 0
>
>
> mor1kx output:
>
>               Carry flag = 1
>
>
>
> Bug 2:
>
> Bug: The EPCR register is accessible from user mode.
>
> Location:  mor1kx_ctrl_cappuccino.v (
> https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_ctrl_cappuccino.v
> <https://urldefense.com/v3/__https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_ctrl_cappuccino.v__;!!KwNVnqRv!SNshfFgKzp1a7X2JYV-4kru80LEyB-7pSHRNT2CfnwuMzUMLkGpkd-6OXtBi6Jz-sng$>
> ).
>
> Details: The OpenRISC specification requires that the EPCR register be
> accessible only from supervisor mode.
>
> Triggering input:
>
> #include <stdio.h>
>
> int main() {
>
>   // enter user mode :
>
>   asm volatile ( "l.ori r17,r0,0x0000  ");
>
>   asm volatile ( "l.mtspr r0,r17,0x3806");
>
>
>   asm volatile ( "l.mfspr r17,r0,0x11  ");
>
>   asm volatile ( "l.andi r17,r17,-2    ");
>
>   asm volatile ( "l.mtspr r0,r17,0x11  ");
>
>   // padding the seed code
>
>   asm volatile( "l.nop 0x0 ");
>
>   asm volatile( "l.nop 0x0 ");
>
>   asm volatile( "l.nop 0x0 ");
>
>   asm volatile( "l.nop 0x0 ");
>
>   asm volatile ("l.addi r1,r0,1");
>
>   asm volatile ("l.mfspr r2,r0,32");
>
>   asm volatile ("l.mtspr r0, r1, 32");
>
>   return 0;
>
> }
>
>
> The or1ksim fails to execute the mfspr while the mor1kx implementation
> can successfully write into EPCR using the mtspr instruction.
>
>
> Bug 3:
>
> Bug: Unable to write to the EEAR register from the supervisor mode.
>
> Location:  mor1kx_ctrl_cappuccino.v (
> https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_ctrl_cappuccino.v
> <https://urldefense.com/v3/__https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_ctrl_cappuccino.v__;!!KwNVnqRv!SNshfFgKzp1a7X2JYV-4kru80LEyB-7pSHRNT2CfnwuMzUMLkGpkd-6OXtBi6Jz-sng$>),
> line 830 to 840.
>
> Details: The OpenRISC specification requires that the EEAR register be
> accessible from the supervisor mode but the mor1kx implementation does not
> have the option to write to EEAR with the mtspr instruction even from the
> supervisor mode.
>
>
> Sincerely,
>
> JV, Ahmad, Aakash, Addison, and Rahul.
>
> --
> JV Rajendran,
> Assistant Professor of Electrical and Computer Engineering,
> Texas A&M University.
> Web: https://cesg.tamu.edu/faculty/jv/
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210902/0a00529f/attachment-0001.htm>
