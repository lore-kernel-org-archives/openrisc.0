From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 09 May 2017 15:21:43 +0100
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 (Stafford Horne's message of "Mon, 24 Apr 2017 21:52:50 +0900")
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
Message-ID: <86o9v2t8js.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:
>  
>        if (reggroup == general_reggroup)
>  	return general_p;
> +
> +      if (strcmp (reg->group, reggroup_name (reggroup)) == 0)
> +	return 1;
> +
>      }

I read the patch again, and find that we can replace the whole block in
"if (reg != NULL && reg->group != NULL)" with the code this patch adds,
like this,

  if (reg != NULL && reg->group != NULL
      && (strcmp (reg->group, reggroup_name (reggroup)) == 0))
     return 1;

-- 
Yao (齐尧)
