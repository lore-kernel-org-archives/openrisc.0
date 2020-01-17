From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 14:51:02 -1000
Subject: [OpenRISC] [PATCH] target/openrisc: Fix FPCSR mask to allow
 setting DZF
In-Reply-To: <20200110212843.27335-1-shorne@gmail.com>
References: <20200110212843.27335-1-shorne@gmail.com>
Message-ID: <7cbf0cfa-2fa7-ed78-d0b4-5b93d012f265@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 1/10/20 11:28 AM, Stafford Horne wrote:
> The mask used when setting FPCSR allows setting bits 10 to 1.  However,
> OpenRISC has flags and config bits in 11 to 1, 11 being Divide by Zero
> Flag (DZF).  This seems like an off-by-one bug.
> 
> This was found when testing the GLIBC test suite which has test cases to
> set and clear all bits.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued.


r~
