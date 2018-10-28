From: Richard Henderson <rth@twiddle.net>
Date: Sun, 28 Oct 2018 01:29:11 +0000
Subject: [OpenRISC] [PATCH v3 0/3] OpenRISC port
In-Reply-To: <20181027043702.18414-1-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
Message-ID: <0a05a35b-19d4-a24c-d072-46f301cd937e@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/27/18 5:36 AM, Stafford Horne wrote:
> Changes Since v2:
>  - Add RTEMS patches from Joel Sherrill
>  - Disable t-softfp-excl as suggsted by Joseph Myers
>  - Add new architecture flags needed to run on real FPGA's found in testing
>    * -mror - enable l.ror (rotate right)
>    * -mshftimm - enable shift/rorate by immediate instructions
>  - Binutils requirements are now in upstream git

I'll just note quickly that you missed gcc-patches in the Cc.  ;-)


r~
