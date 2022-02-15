From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 15 Feb 2022 00:48:03 +0000
Subject: [OpenRISC] [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
In-Reply-To: <20220214163452.1568807-12-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
Message-ID: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:

> -/*
> - * Sparc64 is segmented, though more like the M68K than the I386.
> - * We use the secondary ASI to address user memory, which references a
> - * completely different VM map, thus there is zero chance of the user
> - * doing something queer and tricking us into poking kernel memory.

Actually, this part of comment probably ought to stay - it is relevant
for understanding what's going on (e.g. why is access_ok() always true, etc.)
