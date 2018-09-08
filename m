From: Stafford Horne <shorne@gmail.com>
Date: Sat, 8 Sep 2018 09:29:22 +0900
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
 <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
Message-ID: <20180908002922.GL4594@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 07, 2018 at 05:29:09PM -0500, Samuel Holland wrote:
> On 09/07/18 06:27, Stafford Horne wrote:
> > As many of us know OpenRISC has different classes for instructions.
> > i.e. Class I and Class II.
> > 
> > The Class I instructions are required for all implementation and Class
> > II instructions are optional.   For the new GCC port I have used a few
> > class II instructions.
> > 
> > Does anyone have any opinion if this would be bad or cause issues?  To
> > me I think its OK as I haven't seen a core without these.
> 
> I know of at least one currently-produced silicon implementation[1] based on an
> old or1200 that has a broken l.cmov.
> 
> [1]: https://linux-sunxi.org/AR100
> 
> > Class II Instructions used:
> >        l.extbs  - sign extend byte
> >        l.extbz  - zero extend byte
> >        l.exths  - sign extend half-word
> >        l.exthz  - zero extend half-word
> >        l.cmov  - conditional move
> 
> Looking at or1k.md, you used l.msync and l.ror, and l.sf*i as well. And l.cmov
> and l.sf*i are also used in the libgcc implementation. Those also need to be
> considered.

Thanks, so it looks like we will have to make a flag to enable/disable the class
II instructions to be generated in the output code.

Thanks for the details.  I didnt know it was such a large set of cores missing
those instructions.

-Stafford
