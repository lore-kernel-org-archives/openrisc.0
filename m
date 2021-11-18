From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 18 Nov 2021 22:13:41 +0000
Subject: [OpenRISC] [PATCH v2 03/13] or1k: ABI Implementation
In-Reply-To: <20211113031639.2402161-4-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-4-shorne@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111182213000.1393807@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, 13 Nov 2021, Stafford Horne via Libc-alpha wrote:

> +/* Helper for generic ____longjmp_chk(). */

Don't use () after a function name just to indicate it's a function, as 
opposed to a function call with no arguments (see the GNU Coding 
Standards).

-- 
Joseph S. Myers
joseph at codesourcery.com
