From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Feb 2020 22:18:50 +0900
Subject: [OpenRISC] [PATCH 0/3] OpenRISC clone3 support
In-Reply-To: <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200227122654.ad2tbrohm6ot7pes@wittgenstein>
Message-ID: <20200227131850.GH7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 27, 2020 at 01:26:54PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:22AM +0900, Stafford Horne wrote:
> > This series fixes the clone3 not implemented warnings I have been seeing
> > during recent builds.  It was a simple case of implementing copy_thread_tls
> > and turning on clone3 generic support.  Testing shows no issues.
> 
> This all looks good to me. Thanks for doing this. We're getting closer
> and closer to having all architectures supporting clone3()!
> 
> You want me to pick this series up for 5.7 or are you going through
> another tree?

I am the OpenRISC maintainer so I will just send these through my tree during
the 5.7 merge window with you Ack attributions.

-Stafford
