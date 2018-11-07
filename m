From: Richard Henderson <rth@twiddle.net>
Date: Wed, 7 Nov 2018 09:41:34 +0000
Subject: [OpenRISC] [PATCH v4 0/3] OpenRISC port
In-Reply-To: <20181106212111.31800-1-shorne@gmail.com>
References: <20181106212111.31800-1-shorne@gmail.com>
Message-ID: <c2b12f7b-c4d9-36fc-6eae-efbf42383d7f@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 11/6/18 9:21 PM, Stafford Horne wrote:
> As you can see this is v4 of the OpenRISC port patch series, I just want to
> mention that there are a few things pointed out during the v3 review that I have
> not fixed, and do not plan before pushing upstream.  These are either because I
> didn't feel they made the code easier to read or they were things that could
> wait unil after upstreaming.  These include:
> 
> (not changed)
>  - libgcc !cmov 1cyc improvements suggested by Richard
>  - gcc eliminations refactorings suggested by Segher
>  - leaving out empty constraint strings suggested by Segher
>  - implementing TARGET_ISNS_COST suggested by Segher
> 
> Please let me know if you have concerns; now onto the patches:
> 
> 
> Changes Since v3:
>  - Fix tabs formatting pointed out by Segher
>  - Fix comment formatting and typos pointed out by Segher
>  - Fix for sign/zero extention login in md file from Richard
>  - Remove usages of ATTRIBUTE_UNUSED suggested by Segher
>  - Remove need for init/fini, removing crti/n.S files
>  - Add support for -static-pie in LINK_SPEC suggsted by Szabolcs

All ok.  I agree that the other improvements you detail above can be handled
via normal development.


r~
