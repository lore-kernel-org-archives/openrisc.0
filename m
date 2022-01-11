From: Stafford Horne <shorne@gmail.com>
Date: Wed, 12 Jan 2022 06:12:36 +0900
Subject: [OpenRISC] [PATCH] openrisc: init: Add support for common clk
In-Reply-To: <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
References: <20220111030055.2043568-1-shorne@gmail.com>
 <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
Message-ID: <Yd3yxCPpK81psViU@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 11, 2022 at 05:31:05PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, Jan 11, 2022 at 4:01 AM Stafford Horne <shorne@gmail.com> wrote:
> > When testing the new litex_mmc driver it was found to not work on
> > OpenRISC due to missing support for common clk.  This patch does the
> > basic initialization to allow OpenRISC to use the common clk framework.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks for your patch!
> 
> This matches what other architectures are doing, and is IMHO the way
> forward for sharing FPGA drivers among architectures.
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

-Stafford
