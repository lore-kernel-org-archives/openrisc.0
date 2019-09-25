From: Adam Ford <aford173@gmail.com>
Date: Wed, 25 Sep 2019 07:17:02 -0500
Subject: [OpenRISC] [PATCH v2 00/21] Refine memblock API
In-Reply-To: <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
Message-ID: <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 25, 2019 at 7:12 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Wed, Sep 25, 2019 at 6:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I know it's rather late, but this patch broke the Etnaviv 3D graphics
> > in my i.MX6Q.
> >
> > When I try to use the 3D, it returns some errors and the dmesg log
> > shows some memory allocation errors too:
> > [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> > [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> > [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> > [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> > [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> > memory window
> > [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> > [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> > memory window
>
> This looks similar to what was reported at:
> https://bugs.freedesktop.org/show_bug.cgi?id=111789
>
> Does it help if you use the same suggestion and pass cma=256M in your
> kernel command line?

I tried cma=256M and noticed the cma dump at the beginning didn't
change.  Do we need to setup a reserved-memory node like
imx6ul-ccimx6ulsom.dtsi did?

adam
