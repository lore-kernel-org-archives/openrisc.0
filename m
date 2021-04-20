From: Stafford Horne <shorne@gmail.com>
Date: Wed, 21 Apr 2021 06:53:34 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC large binary fixes
In-Reply-To: <20210419000524.3625897-1-shorne@gmail.com>
References: <20210419000524.3625897-1-shorne@gmail.com>
Message-ID: <20210420215334.GN3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Apr 19, 2021 at 09:05:20AM +0900, Stafford Horne wrote:
> These are several fixes to OpenRISC BFD to handle issues mostly related to
> linking large files.
> 
> There will be a GCC patch then depends on this, a new -mcmodel=large argument is
> added to GCC to allow creating GOT relocation values larger than 64k.
> 
> The series fixes 3 issues:
> 
>  * PR 27624 - Assertion failure when dynamic symol is localized
>  * PR 21464 - GOT relocation truncation.
>  * PR 27746 - Issue with silent overlows in PLT code.

As discussed offline with Giulio, this series does not properly fix the PR 21464
issue.  I have fixed the issue and will post a v2 after I fix some other things
uncovered...

Instead of using large PLTs whenever we see gotha() relocations, I will try to
detect when the plt_relocation overflows and switch to use the large model then.

This is needed as the gcc crtstuff will now always have gotha() relocations, with
the current binutils this would cause the large PLT code to always be generated.
We don't want that.

-Stafford
