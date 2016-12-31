From: Jonas Bonn <jonas@southpole.se>
Date: Sat, 31 Dec 2016 15:10:37 +0100
Subject: [OpenRISC] [PATCH 0/3] Openrisc 4.10 fixes
In-Reply-To: <cover.1483184705.git.shorne@gmail.com>
References: <cover.1483184705.git.shorne@gmail.com>
Message-ID: <5edddd32-2a31-8b52-adfa-f5edae1fc227@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On 12/31/2016 12:52 PM, Stafford Horne wrote:
> Hello,
>
> These are a few small changes for openrisc I would like to include in 4.10.
> The main change is a fix for building with alldefconfig to properly setup
> then _text symbol.  Others are trivial.
>
> If no complaints I will push to 4.10 for inclusion and start working on
> 4.11 changes.

Post-merge window patches should  be bug fixes, only.  Patch 1/3 
probably qualifies, but the others are far too trivial to be pushing 
now.  Just put them on your 4.11 branch.

>
> Let me know if these are too minor to even post for review.
Nothing is too minor to post for review!

/Jonas

>
> Stafford Horne (3):
>    openrisc: Add _text symbol to fix ksym build error
>    openrisc: Add .gitignore
>    MAINTAINERS: Add the openrisc official repository
>
>   MAINTAINERS                        | 1 +
>   arch/openrisc/kernel/.gitignore    | 1 +
>   arch/openrisc/kernel/vmlinux.lds.S | 2 ++
>   3 files changed, 4 insertions(+)
>   create mode 100644 arch/openrisc/kernel/.gitignore
>


