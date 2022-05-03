From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue, 3 May 2022 11:59:57 +0200
Subject: [OpenRISC] [PATCH] hw/openrisc: use right OMPIC size variable
In-Reply-To: <YnDzoWHqpYcCWTVs@antec>
References: <20220502232800.259036-1-Jason@zx2c4.com>
 <c6d3a823-b9a4-411a-b4b8-5fb1f1c9c214@linaro.org>
 <YnDzoWHqpYcCWTVs@antec>
Message-ID: <YnD9HZNm0Sph1hLr@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 03, 2022 at 06:19:29PM +0900, Stafford Horne wrote:
> On Mon, May 02, 2022 at 04:59:47PM -0700, Richard Henderson wrote:
> > On 5/2/22 16:28, Jason A. Donenfeld wrote:
> > > This appears to be a copy and paste error. The UART size was used
> > > instead of the much smaller OMPIC size.
> > > 
> > > Signed-off-by: Jason A. Donenfeld<Jason@zx2c4.com>
> > > ---
> > >   hw/openrisc/openrisc_sim.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Thanks,
> 
> I will queue this one.
> 
Please take a look at the v2 I posted instead.
