From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jul 2019 09:49:02 -0500
Subject: [OpenRISC] [PATCH v2 3/5] or1k: Add mrori option,
 fix option docs
In-Reply-To: <20190703033351.11924-4-shorne@gmail.com>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-4-shorne@gmail.com>
Message-ID: <20190703144902.GX18316@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jul 03, 2019 at 12:33:49PM +0900, Stafford Horne wrote:
> @@ -179,11 +183,11 @@
>    [(set (match_operand:SI 0 "register_operand" "=r,r")
>  	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
>  		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
> -  "TARGET_ROR"
> +  "TARGET_ROR || TARGET_RORI"
>    "@
>     l.ror\t%0, %1, %2
>     l.rori\t%0, %1, %2"
> -  [(set_attr "insn_support" "*,shftimm")])
> +  [(set_attr "insn_support" "ror,rori")])

Does this work?  If you use -mno-ror -mrori?  It will then allow generating
a reg for the second operand, and ICE later on, as far as I can see?


Segher
