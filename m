From: Kees Cook <keescook@chromium.org>
Date: Tue, 12 Oct 2021 23:45:47 -0700
Subject: [OpenRISC] [PATCH 2/2] kbuild: use more subdir- for visiting
 subdirectories while cleaning
In-Reply-To: <20211013063622.548590-2-masahiroy@kernel.org>
References: <20211013063622.548590-1-masahiroy@kernel.org>
 <20211013063622.548590-2-masahiroy@kernel.org>
Message-ID: <202110122345.4B8FE35AED@keescook>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 13, 2021 at 03:36:22PM +0900, Masahiro Yamada wrote:
> Documentation/kbuild/makefiles.rst suggests to use "archclean" for
> cleaning arch/$(SRCARCH)/boot/.
> 
> Since commit d92cc4d51643 ("kbuild: require all architectures to have
> arch/$(SRCARCH)/Kbuild"), we can use the "subdir- += boot" trick for
> all architectures. This can take advantage of the parallel option (-j)
> for "make clean".
> 
> I also cleaned up the comments. The "archdep" target does not exist.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I like the clean-up!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
