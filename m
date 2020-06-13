From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Jun 2020 11:19:37 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for v5.8
In-Reply-To: <20200613021757.GM75760@lianli.shorne-pla.net>
References: <20200613021757.GM75760@lianli.shorne-pla.net>
Message-ID: <20200613021937.GN75760@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

CCing list.

On Sat, Jun 13, 2020 at 11:17:57AM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider for pull:
> 
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 6bd140e14d9aaa734ec37985b8b20a96c0ece948:
> 
>   openrisc: Fix issue with argument clobbering for clone/fork (2020-06-01 06:15:32 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC updates for 5.8
> 
> One patch found wile I was getting the glibc port ready:
>  - Fix issue with clone TLS arg getting overwritten
> 
> ----------------------------------------------------------------
> Stafford Horne (1):
>       openrisc: Fix issue with argument clobbering for clone/fork
> 
>  arch/openrisc/kernel/entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
