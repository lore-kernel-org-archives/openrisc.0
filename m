From: Stafford Horne <shorne@gmail.com>
Date: Mon, 2 Mar 2020 18:14:20 +0900
Subject: [OpenRISC] [PATCH v2 0/3] OpenRISC clone3 support
In-Reply-To: <20200302074411.p56ctghzllrijrqz@wittgenstein>
References: <20200301213851.8096-1-shorne@gmail.com>
 <20200302074411.p56ctghzllrijrqz@wittgenstein>
Message-ID: <20200302091420.GJ7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 02, 2020 at 08:44:11AM +0100, Christian Brauner wrote:
> On Mon, Mar 02, 2020 at 06:38:48AM +0900, Stafford Horne wrote:
> > This series fixes the clone3 not implemented warnings I have been seeing
> > during recent builds.  It was a simple case of implementing copy_thread_tls
> > and turning on clone3 generic support.  Testing shows no issues.
> > 
> > Changes since v1:
> > 
> >  - Fix some comments pointed out in reviews
> >  - Add Acks to 2/3 and 3/3 from Christian Brauner
> 
> Excellent. I acked all individual patches now. But the whole series:
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks a lot for the review.

-Stafford
