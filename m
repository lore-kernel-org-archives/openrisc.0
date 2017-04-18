From: Stafford Horne <shorne@gmail.com>
Date: Tue, 18 Apr 2017 23:26:24 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH 4/7] target/openrisc: implement
 shadow registers
In-Reply-To: <5447c3cd-4b64-3b71-fd77-33a29f225104@twiddle.net>
References: <cover.1492384862.git.shorne@gmail.com>
 <b1be5af9a1d304f55847efeab706e88e3b9b1afa.1492384862.git.shorne@gmail.com>
 <5447c3cd-4b64-3b71-fd77-33a29f225104@twiddle.net>
Message-ID: <20170418142624.GC2599@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 01:11:53AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > Shadow registers are part of the openrisc spec along with sr[cid], as
> > part of the fast context switching feature.  When exceptions occur,
> > instead of having to save registers to the stack if enabled the CID will
> > increment and a new set of registers will be available.
> > 
> > This patch only implements shadow registers which can be used as extra
> > scratch registers via the mfspr and mtspr if required.  This is
> > implemented in a way where it would be easy to add on the fast context
> > switching, currently cid is hardcoded to 0.
> 
> I'm not especially keen on this half-conversion.
> If CID cannot be changed, then
> 
> > -    target_ulong gpr[32];     /* General registers */
> > +    target_ulong shadow_gpr[16][32]; /* Shadow registers */
> > +    target_ulong * gpr;       /* General registers (backed by shadow) */
> 
> this pointer should not be necessary.  Just use a union, or even just
> 
>     target_ulong gpr[32];
>     target_ulong shadow_gpr[15][32];
> 
> for now.
> 
> Alternately, add accessor functions that take the whole ENV (which would be
> able to read CID, when needed).  C.f.
> 
>     uint64_t cpu_alpha_load_gr(CPUAlphaState *env, unsigned reg);
>     void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);

Actually, I started off writing it this way, but there were a lot of places
that used env->gpr.  I had some regex's to replace everything, but in the
end I thought using the gpr pointer was just easier.

Using the union would work as well, but it wouldnt help to allow switching
of cid.  My idea with the pointer was that if cid was updates I could
update the pointer at that time.

Ill rework this to use the accessor functions.

-Stafford

> If/when CID can be changed, then we can talk about various ways
> that this can be modeled within TCG.
> 
> 
> r~
