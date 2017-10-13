From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 23:31:54 +0900
Subject: [OpenRISC] [PATCH v2 2/5] target/openrisc: Make coreid and
	numcores variable
In-Reply-To: <068db9d2-2805-2dac-4c19-efc6d187db44@linaro.org>
References: <20171013134930.32547-1-shorne@gmail.com>
 <20171013134930.32547-3-shorne@gmail.com>
 <068db9d2-2805-2dac-4c19-efc6d187db44@linaro.org>
Message-ID: <20171013143154.GF2958@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Oct 13, 2017 at 06:58:21AM -0700, Richard Henderson wrote:
> On 10/13/2017 06:49 AM, Stafford Horne wrote:
> > Previously coreid and numcores were hard coded as 0 and 1 respectively
> > as OpenRISC QEMU did not have multicore support.
> > 
> > Multicore support is now being added so these registers need to have
> > configured values.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  target/openrisc/sys_helper.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

Thank you for the review.

-Stafford
