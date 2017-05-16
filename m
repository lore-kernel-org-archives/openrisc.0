From: Stafford Horne <shorne@gmail.com>
Date: Tue, 16 May 2017 20:20:23 +0900
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <86o9v2t8js.fsf@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 <86o9v2t8js.fsf@gmail.com>
Message-ID: <20170516112023.GE2440@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, May 09, 2017 at 03:21:43PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> >  
> >        if (reggroup == general_reggroup)
> >  	return general_p;
> > +
> > +      if (strcmp (reg->group, reggroup_name (reggroup)) == 0)
> > +	return 1;
> > +
> >      }
> 
> I read the patch again, and find that we can replace the whole block in
> "if (reg != NULL && reg->group != NULL)" with the code this patch adds,
> like this,
> 
>   if (reg != NULL && reg->group != NULL
>       && (strcmp (reg->group, reggroup_name (reggroup)) == 0))
>      return 1;

Thanks,  I was thinking to simply to this as well,  but I left the patch I
inheherited as is.  I will also update the commit log and comment to make
it more clear what is going on.

> -- 
> Yao (齐尧)
