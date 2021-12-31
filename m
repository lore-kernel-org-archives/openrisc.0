From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 31 Dec 2021 17:45:05 +0000
Subject: [OpenRISC] [PATCH v4 10/13] or1k: ABI lists
In-Reply-To: <20211229044251.2203653-11-shorne@gmail.com>
References: <20211229044251.2203653-1-shorne@gmail.com>
 <20211229044251.2203653-11-shorne@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112311744180.2293191@digraph.polyomino.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 29 Dec 2021, Stafford Horne via Libc-alpha wrote:

>  sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +

As noted for the LoongArch port submission, I don't think new ports should 
have libnsl or an ABI test baseline for it.

-- 
Joseph S. Myers
joseph at codesourcery.com
