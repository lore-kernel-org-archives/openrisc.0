From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Mon, 04 Sep 2017 23:14:13 +0200
Subject: [OpenRISC] [PATCH v4 3/5] sim: or1k: add or1k target to sim
In-Reply-To: <aaf9bb46e9b3a59d1fff197c08fa25c7e0bd3b16.1496066478.git.shorne@gmail.com>
References: <cover.1496066478.git.shorne@gmail.com>
 <aaf9bb46e9b3a59d1fff197c08fa25c7e0bd3b16.1496066478.git.shorne@gmail.com>
Message-ID: <617acff0490f4ae9ffcf961fb55b2ef1@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

I started to look at this patch, and I have to say that it's quite 
difficult for an outsider like me to follow.  I can see what the code is 
doing, and can correlate some parts with the openrisc spec.  But since 
there are no comments at all, I have no idea what the intents are, so I 
can't really tell whether the code is right or wrong wrt the intent.  
Maybe it's just because of my lack of experience in the area, and 
somebody familiar with the sim code would find it obvious.  Still, I 
think adding some comments would help future contributors.

For example, in or1k_cpu_init:

> +void
> +or1k_cpu_init (SIM_DESC sd, sim_cpu * current_cpu, const USI or1k_vr,
> +	       const USI or1k_upr, const USI or1k_cpucfgr)
> +{
> +  SET_H_SYS_VR (or1k_vr);
> +  SET_H_SYS_UPR (or1k_upr);
> +  SET_H_SYS_CPUCFGR (or1k_cpucfgr);
> +
> +#define CHECK_SPR_FIELD(GROUP, INDEX, FIELD, test)                     
>  \
> +  do {                                                                 
>  \
> +    USI field = GET_H_##SYS##_##INDEX##_##FIELD ();                    
>  \
> +    if (!(test)) {                                                     
>  \
> +      sim_io_eprintf(sd, "WARNING: unsupported %s field in %s
> register: 0x%x\n", \
> +                     #FIELD, #INDEX, field);                           
>  \
> +    }                                                                  
>  \
> +  } while (0)
> +
> +  current_cpu->next_delay_slot = 0;
> +  current_cpu->delay_slot = 0;
> +
> +  CHECK_SPR_FIELD (SYS, UPR, UP, field == 1);
> +  CHECK_SPR_FIELD (SYS, UPR, DCP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, ICP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, DMP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, MP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, IMP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, DUP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, PCUP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, PICP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, PMP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, TTP, field == 0);
> +  CHECK_SPR_FIELD (SYS, UPR, CUP, field == 0);
> +
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, NSGR, field == 0);
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, CGF, field == 0);
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, OB32S, field == 1);
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, OB64S, field == 0);
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, OF64S, field == 0);
> +  CHECK_SPR_FIELD (SYS, CPUCFGR, OV64S, field == 0);

Here, I think a comment should explain what these checks are about.  I 
understand they are checking for CPU features, making sure they are or 
aren't there, but why?

> +
> +#undef CHECK_SPR_FIELD
> +
> +  SET_H_SYS_UPR_UP (1);

This, looks fishy to me, but maybe there's a good reason for it to be 
there?  In the checks above we made sure that the UP bit of the UPR 
register was set.  Why do we need to set it here?

I understand that there can't be (and we don't want) a comment for each 
source line, but at least some high level ones.

Thanks,

Simon
