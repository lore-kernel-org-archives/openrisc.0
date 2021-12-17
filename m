From: Stafford Horne <shorne@gmail.com>
Date: Sat, 18 Dec 2021 00:02:29 +0900
Subject: [OpenRISC] [PATCH v3 07/13] or1k: math soft float support
In-Reply-To: <0ec2704d-e916-63cf-f338-a9c70ec4b66f@linaro.org>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-8-shorne@gmail.com>
 <0ec2704d-e916-63cf-f338-a9c70ec4b66f@linaro.org>
Message-ID: <YbymhURyZCZKOU3Z@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 16, 2021 at 04:48:06PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> > OpenRISC support hard float but I will like to submit that after glibc
> > soft float goes upstream.  The hard float support depends on adding user
> > access to the FPCSR, which is not supported by the kernel yet.
> 
> The patch looks ok in general, the fenv bits matches the documentation. 

Thank you.
