From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2019 12:17:28 -0300
Subject: [OpenRISC] [PATCH v2 00/21] Refine memblock API
In-Reply-To: <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
 <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
Message-ID: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 25, 2019 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:

> I tried cma=256M and noticed the cma dump at the beginning didn't
> change.  Do we need to setup a reserved-memory node like
> imx6ul-ccimx6ulsom.dtsi did?

I don't think so.

Were you able to identify what was the exact commit that caused such regression?
