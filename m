Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED0C4167D
	for <openrisc@archiver.kernel.org>; Thu,  6 Oct 2022 16:19:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 60AAD2491E;
	Thu,  6 Oct 2022 18:18:59 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id C1CA124B60
 for <openrisc@lists.librecores.org>; Tue,  4 Oct 2022 13:13:20 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 o9-20020a17090a0a0900b0020ad4e758b3so2200366pjo.4
 for <openrisc@lists.librecores.org>; Tue, 04 Oct 2022 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=UHE2x7YnT+avJBdJRK8fICu4tqbTB0zv1A8Jd5IOhrw=;
 b=DQ7AqshQw7pAlndMjmyEf3HDNlexUBF+jB73J+4SoV4OjFHAeL9d93Pkb0EJq27wmV
 fMsaB2Ugk2jANVVFsgCVCwsCPcqfEpNwL8Phil7GBZGqFbBPLY20X/vyyyMA3GQqxwqr
 9GitSfUr/lUWnkoEFyKfW1UEPWDsM/lhvI/GgsbbZeTjM/BKXmE2CDDRkoVqqPha6oPu
 qT7JzbFbc8JYxA1Hnfg8ebCiWushyc4cczI9HWkbShP/pG31SGJukNeZLdU4X/4Dr/J1
 nBm7WS/ywrZAsUI2kefDBEEPXrA2HSCWcStoD/F24lMd+RQ2O+RyHYdGsKRKL5ywBm+U
 IhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=UHE2x7YnT+avJBdJRK8fICu4tqbTB0zv1A8Jd5IOhrw=;
 b=hbagq0ME8csHcggA7fVySzjQfzIbma+3edvWzDjCPnp7l8Et0NW4kuPep3RM/Br9na
 +BW0BSL6xgExrbXJx3cTQtbkeSpqBWYYy1ZRMQX4WLi2xzcI4kFiZtGt4GV6xn53POt+
 v6wCTrKnF/uLg+IwDvgYEe6SNgrqvCcNJnwRXVpTPce23LNbVZjtrfosjJ3de+J20xLt
 /GhZC01ptV87J38xQUmM4Psu+Ff1sbqs9PvjJcAViuV2zK0eqd2fLvOHLesD8IWRKZLx
 sXqHh9w1CLNPkj6BstaRA/Tk9MtKZgToy229Se1ojsxiK9uZlat6UBoujW+TKvVrhjmb
 z/Qw==
X-Gm-Message-State: ACrzQf0PbLvraFTo3FicjP2FPE/+JZHFb8DkWT6zlNxFA8hUoYBCeEFB
 z5WXBkvUiN4M/Ff8rb5Gni+YHJbR5SuAomI9rQDcKQ==
X-Google-Smtp-Source: AMsMyM7BhQDEzGuMq6uijGe+375QPbx+j/BjXkPK0/Xp2Q5WyeWrXvzrh6ljkVul43PLHCDTtENmDZivDluO/kqNLsY=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr17237644pjb.164.1664881999182; Tue, 04
 Oct 2022 04:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org>
 <20220919101522.908560022@infradead.org>
In-Reply-To: <20220919101522.908560022@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Oct 2022 13:12:42 +0200
Message-ID: <CAPDyKFqDiqXSi5Gn9eyvhHhqHxJAPAt-HzmEDwYWaGvso2yn=w@mail.gmail.com>
Subject: Re: [PATCH v2 38/44] cpuidle,powerdomain: Remove trace_.*_rcuidle()
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Oct 2022 18:18:55 +0200
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, mpe@ellerman.id.au, linux-sh@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org, mingo@redhat.com,
 linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com,
 lpieralisi@kernel.org, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de,
 linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 svens@linux.ibm.com, kernel@pengutronix.de, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, festevam@gmail.com, deller@gmx.de,
 daniel.lezcano@linaro.org, jonathanh@nvidia.com, dennis@kernel.org,
 lenb@kernel.org, linux-xtensa@linux-xtensa.org, jolsa@kernel.org,
 gor@linux.ibm.com, linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev, chris@zankel.net,
 sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 chenhuacai@kernel.org, alexander.shishkin@linux.intel.com, fweisbec@gmail.com,
 mturquette@baylibre.com, paul.walmsley@sifive.com, linux@rasmusvillemoes.dk,
 christophe.leroy@csgroup.eu, will@kernel.org, boris.ostrovsky@oracle.com,
 khilman@kernel.org, linux-csky@vger.kernel.org, tony@atomide.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, rostedt@goodmis.org, ink@jurassic.park.msu.ru,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 anup@brainfault.org, ryabinin.a.a@gmail.com, linux-alpha@vger.kernel.org,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org,
 pv-drivers@vmware.com, hpa@zytor.com, konrad.dybcio@somainline.org,
 bjorn.andersson@linaro.org, glider@google.com, amakhalov@vmware.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincenzo.frascino@arm.com, anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk,
 agross@kernel.org, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 richard.henderson@linaro.org, openrisc@lists.librecores.org, acme@kernel.org,
 atishp@atishpatra.org, linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, dvyukov@google.com,
 jgross@suse.com, monstr@monstr.eu, linux-mips@vger.kernel.org,
 palmer@dabbelt.com, linux-hexagon@vger.kernel.org, bp@alien8.de,
 johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> OMAP was the one and only user.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There are changes to the runtime PM core as part of $subject patch.
Perhaps move those parts into a separate patch? In any case, the code
looks good to me.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/mach-omap2/powerdomain.c |   10 +++++-----
>  drivers/base/power/runtime.c      |   24 ++++++++++++------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -187,9 +187,9 @@ static int _pwrdm_state_switch(struct po
>                         trace_state = (PWRDM_TRACE_STATES_FLAG |
>                                        ((next & OMAP_POWERSTATE_MASK) << 8) |
>                                        ((prev & OMAP_POWERSTATE_MASK) << 0));
> -                       trace_power_domain_target_rcuidle(pwrdm->name,
> -                                                         trace_state,
> -                                                         raw_smp_processor_id());
> +                       trace_power_domain_target(pwrdm->name,
> +                                                 trace_state,
> +                                                 raw_smp_processor_id());
>                 }
>                 break;
>         default:
> @@ -541,8 +541,8 @@ int pwrdm_set_next_pwrst(struct powerdom
>
>         if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>                 /* Trace the pwrdm desired target state */
> -               trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
> -                                                 raw_smp_processor_id());
> +               trace_power_domain_target(pwrdm->name, pwrst,
> +                                         raw_smp_processor_id());
>                 /* Program the pwrdm desired target state */
>                 ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>         }
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -442,7 +442,7 @@ static int rpm_idle(struct device *dev,
>         int (*callback)(struct device *);
>         int retval;
>
> -       trace_rpm_idle_rcuidle(dev, rpmflags);
> +       trace_rpm_idle(dev, rpmflags);
>         retval = rpm_check_suspend_allowed(dev);
>         if (retval < 0)
>                 ;       /* Conditions are wrong. */
> @@ -481,7 +481,7 @@ static int rpm_idle(struct device *dev,
>                         dev->power.request_pending = true;
>                         queue_work(pm_wq, &dev->power.work);
>                 }
> -               trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
> +               trace_rpm_return_int(dev, _THIS_IP_, 0);
>                 return 0;
>         }
>
> @@ -493,7 +493,7 @@ static int rpm_idle(struct device *dev,
>         wake_up_all(&dev->power.wait_queue);
>
>   out:
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>         return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
>  }
>
> @@ -557,7 +557,7 @@ static int rpm_suspend(struct device *de
>         struct device *parent = NULL;
>         int retval;
>
> -       trace_rpm_suspend_rcuidle(dev, rpmflags);
> +       trace_rpm_suspend(dev, rpmflags);
>
>   repeat:
>         retval = rpm_check_suspend_allowed(dev);
> @@ -708,7 +708,7 @@ static int rpm_suspend(struct device *de
>         }
>
>   out:
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>
>         return retval;
>
> @@ -760,7 +760,7 @@ static int rpm_resume(struct device *dev
>         struct device *parent = NULL;
>         int retval = 0;
>
> -       trace_rpm_resume_rcuidle(dev, rpmflags);
> +       trace_rpm_resume(dev, rpmflags);
>
>   repeat:
>         if (dev->power.runtime_error) {
> @@ -925,7 +925,7 @@ static int rpm_resume(struct device *dev
>                 spin_lock_irq(&dev->power.lock);
>         }
>
> -       trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
> +       trace_rpm_return_int(dev, _THIS_IP_, retval);
>
>         return retval;
>  }
> @@ -1081,7 +1081,7 @@ int __pm_runtime_idle(struct device *dev
>                 if (retval < 0) {
>                         return retval;
>                 } else if (retval > 0) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +                       trace_rpm_usage(dev, rpmflags);
>                         return 0;
>                 }
>         }
> @@ -1119,7 +1119,7 @@ int __pm_runtime_suspend(struct device *
>                 if (retval < 0) {
>                         return retval;
>                 } else if (retval > 0) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +                       trace_rpm_usage(dev, rpmflags);
>                         return 0;
>                 }
>         }
> @@ -1202,7 +1202,7 @@ int pm_runtime_get_if_active(struct devi
>         } else {
>                 retval = atomic_inc_not_zero(&dev->power.usage_count);
>         }
> -       trace_rpm_usage_rcuidle(dev, 0);
> +       trace_rpm_usage(dev, 0);
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>
>         return retval;
> @@ -1566,7 +1566,7 @@ void pm_runtime_allow(struct device *dev
>         if (ret == 0)
>                 rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
>         else if (ret > 0)
> -               trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> +               trace_rpm_usage(dev, RPM_AUTO | RPM_ASYNC);
>
>   out:
>         spin_unlock_irq(&dev->power.lock);
> @@ -1635,7 +1635,7 @@ static void update_autosuspend(struct de
>                         atomic_inc(&dev->power.usage_count);
>                         rpm_resume(dev, 0);
>                 } else {
> -                       trace_rpm_usage_rcuidle(dev, 0);
> +                       trace_rpm_usage(dev, 0);
>                 }
>         }
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
