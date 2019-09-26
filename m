From: Adam Ford <aford173@gmail.com>
Date: Thu, 26 Sep 2019 08:09:52 -0500
Subject: [OpenRISC] [PATCH v2 00/21] Refine memblock API
In-Reply-To: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
 <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
 <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
Message-ID: <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 25, 2019 at 10:17 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I tried cma=256M and noticed the cma dump at the beginning didn't
> > change.  Do we need to setup a reserved-memory node like
> > imx6ul-ccimx6ulsom.dtsi did?
>
> I don't think so.
>
> Were you able to identify what was the exact commit that caused such regression?

I was able to narrow it down the 92d12f9544b7 ("memblock: refactor
internal allocation functions") that caused the regression with
Etnaviv.

I also noticed that if I create a reserved memory node as was done one
imx6ul-ccimx6ulsom.dtsi the 3D seems to work again, but without it, I
was getting errors regardless of the 'cma=256M' or not.
I don't have a problem using the reserved memory, but I guess I am not
sure what the amount should be.  I know for the video decoding 1080p,
I have historically used cma=128M, but with the 3D also needing some
memory allocation, is that enough or should I use 256M?

adam
