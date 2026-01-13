Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3402DB7A1
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321069; cv=none; b=GOZoRrtufIOhAUynYqoEnnti2uHE4IxNq6Qeu/FAqmsvqLAHB2E+1mAaesbPhJx8QGAQeXnfujECw0kqsxqgGlVfkhI4b28pOfEDKdGCG5COgGlq+4y+WWdEaFqyh4xHtDxr8fl+oCyt0ZyQn6GtAMIV1ir9aNhm8hlj67DpoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321069; c=relaxed/simple;
	bh=yMU7RpmbGUQmgjsLmbNXZu5aW050fDW5MvKwtfgFqbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPjvyJbpzqIUz36cKfkU+IZf4A86agajFZQbSd5KKyb9KPrdKP9UjFNabzYJCboNme2ZbhuxqK8ksTeJyAvsuoYIV0YEjNSnT5T//LygPETA26akyN5JU0GFl/ANQcBA+KISYAMgx82YSA4viExM/bPcAXLFPfwAliS7FB1unBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOmuMFYK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOmuMFYK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so71155855e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768321065; x=1768925865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W5cQ5QbTEmkxlUwQtqiRbc+zlLlHGcmwQl/sOQIOejY=;
        b=mOmuMFYK3cMMLXUbn18dKxh4ntuwCPofy0p/wza2YLcAvXEncPZaUzVDnszC5vUuCr
         EtwKO47htMVN5EdpERh46uz6wEXHZHEDSuW67mUPTdzFF1wlMWoYzbnn9MWrN/3JieGc
         txD5TKpF7U8PPN2WW9o4JOawzYN8WC1tReCsBW65eNGXEDkZzg8np8NuAcCoONqX8oVO
         187MKh1LzZe9pdyfZyV139pIKhtcIEC2NPRbrMj8XEF0qcdIfKHqJJutVAWAeoKwYfjA
         tSfQ09mBre4EIs6lT8YK703RZR+TEpxmdfBvemDwnhriY70Mzl4L6YOSVIfvNEdvN8PX
         lWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321065; x=1768925865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5cQ5QbTEmkxlUwQtqiRbc+zlLlHGcmwQl/sOQIOejY=;
        b=L5gHWwu3QlTHBDTNqODCji9OhzndMxJX9J3IgWY8H46QsFSRhoGMt0SJ3xVwgHUyZe
         FRnGXGJ7G3l1/6ZmRni7CAiT4Cj8yQNQ4DnnvkDzJgRghzTKAhJQiOFtP1mV9OyId57F
         rg45mNwNLyU/RPZCr+RFMh0P124rOBvJ7OmCnSpjdBd/CkTofIv3O4CP3StbUjNpGgi5
         usWK9hYria/QAiHt0s/IUJ3uqSqxLvMhs3GKDYT8qv2cx5baqS06hYdNg+7sIRtoMmxa
         zBh9MgkaDia1y9nrl/H/EWTiXO9nA198Ieqq4Hd0jPRIILBe9lGu6whA8R0WGu3WappH
         extQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSpuh/Rjcm8H2v/RldVp/28wzN/8d8Ph5LbLoX0jXtZMJaZqg14ZNZz4OyPz9JT6RheQ3UjnAJ5ELu0V2EjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUD4tPUeu3NfGx8MeJtwbxUKkXF/2qv+/sKjlnuIveyJm3OOk8
	VK8iXghqUJpN4JAhAoIVC4xL/Wb20Z4iXLQ3bBYSpmv06a7hHt0o4D2y
X-Gm-Gg: AY/fxX7Hhj3MT1QNT6oICJKSzPWO79GLl5Mhs9zev5+WwWitSH8Upf1XAIxFBzmUhJD
	QsylYegtyOfeptv4jlFsg23z9Jc/uN944EL4vIiiBA/yTfF5HroEweAJuiA2iNsv+Qab6XASb5D
	uPiG+oO/JqK1IzMWfcrbjoLz7uSd4WSCedip+1pbo78adxDB5jaVujZ44bQPCcjSzZ5U8iCVAfp
	9Kfrn7Nb+HDLD7MM8fI+j4W2Ml+xgUV2tOkFCM+TZ61bpj9qs/UhHOT8vhn2+cE9Urzry8hkZlr
	A++OvoKs0KWynYGDR6D+kCT/1YRxhAfZP2WdNrfgFE1tOLqngl7y93d2VOBtdYe7ZSlSzyOogPe
	aoXpOftvfFPLVnmOMzzIkzz0UBxhAr9Fi7mPTivFrHknskLcTzJ9PZFqEogCnX8GQP4AiFDHrjA
	3XibKcV5YUa9I2E1fck23db2xhoFV7cQs7AAYLr6qniOtlVQaAm+sJCyOnLx+2PKfo
X-Google-Smtp-Source: AGHT+IEAzrK93inVXSrX8Kw6zVEeuZ0+E8dHH/rXiqvCESoJ7JG5E/eH8JB47SON6HhjECNrEiGHSQ==
X-Received: by 2002:a05:600c:34cb:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d8f287ae3mr154134765e9.34.1768321064788;
        Tue, 13 Jan 2026 08:17:44 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edc05b267sm36951725e9.15.2026.01.13.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:17:43 -0800 (PST)
Date: Tue, 13 Jan 2026 16:17:43 +0000
From: Stafford Horne <shorne@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
Message-ID: <aWZwJ569WMBOKUVc@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-2-shorne@gmail.com>
 <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>
 <aV9o1LL0Ahip0O3-@antec>
 <CAMuHMdXYCNR0ANn152ghFExpWY_yZ5+kyFGGRwA+X-EFUvxZXw@mail.gmail.com>
 <CAD++jLm1u9ChqsftwvbOptiG3Qo2KWxPjqN2snOVuZDYuVST5Q@mail.gmail.com>
 <aWD53y15NuxrKGxf@antec>
 <CAMRc=Mcq256VgbKf82DBrvPhyYfUioCnfBOg23L3RkA6X8qSGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq256VgbKf82DBrvPhyYfUioCnfBOg23L3RkA6X8qSGA@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:25:03AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 9, 2026 at 1:51 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Fri, Jan 09, 2026 at 11:07:17AM +0100, Linus Walleij wrote:
> > > On Thu, Jan 8, 2026 at 9:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > > > > What is the rationale behind using brcm,bcm6345-gpio?
> > > > > > Given brcm,bcm6345-gpio has 32-bit registers, while opencores,gpio
> > > > > > has 8-bit registers, I doubt the latter is compatible with the former...
> > >
> > > Yeah this needs to be fixed/reverted pronto :/
> > >
> > > > > I switch the size from 32-bit to 8-bit using the reg = <* 0x1>, <* 0x1> setting.
> > > > > Also the reg addresses of "dat" and "dirout" are different for the real
> > > > > brcm,bcm6345-gpio.
> > > > >
> > > > > brcm,bcm6345-gpio. Example:
> > > > >
> > > > >        /* GPIOs 192 .. 223 */
> > > > >        gpio6: gpio@518 {
> > > > >                compatible = "brcm,bcm6345-gpio";
> > > > >                reg = <0x518 0x04>, <0x538 0x04>;
> > > > >                reg-names = "dirout", "dat";
> > > > >                gpio-controller;
> > > > >                #gpio-cells = <2>;
> > > > >        };
> > > > >
> > > > > vs opencores,gpio Example:
> > > > >
> > > > >        gpio0: gpio@91000000 {
> > > > >                compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> > > > >                reg = <0x91000000 0x1>, <0x91000001 0x1>;
> > > > >                reg-names = "dat", "dirout";
> > > > >                gpio-controller;
> > > > >                #gpio-cells = <2>;
> > > > >        };
> > > >
> > > > Exactly, the register space and register widths are different
> > >
> > > ...as proved here.
> > >
> > > Stafford can you send a fixup or revert patch?
> > > (Only need to revert if you can't make a fix quick enough, which I
> > > think you can.)
> >
> > Sure, I'll send a fixup to the devicetree binding and a update to the driver to
> > just support opencores,gpio.
> >
> 
> I assume, the v3 you sent is *not* it and you will send a v4 with
> issues pointed out by Krzysztof fixes?

Yes, I have just sent out the v4.

> > Hopefully, that can be picked up in time by Bartosz who has this one staged in
> > gpio/for-next.
> >
> 
> I'm ready to pick it up as soon as Krzysztof Acks it.

OK.

> > I'll send the 2 patches as part of my series for OpenRISC multicore fixups as
> > the devicetree's I have added have a soft dependency the patches.  After/if the
> > patches are pulled to the gpio branch I can drop them from my queue and I'll
> > just have to make sure Linux merged the GPIO changes binding updates before the
> > OpenRISC updates during the merge window.  Let me know if there are any issues.
> >
> 
> Sounds good.

Thank you.

-Stafford

> > > > > The opencores,gpio setup does work.
> > > > >
> > > > > Now that I think about it, would it have been better to just add opencores,gpio
> > > > > to gpio-mmio.c compatible list?
> > > >
> > > > I think that would be better.
> > >
> > > Yes this is better.
> > >
> > > I should have seen this, I guess I was sloppy :(
> >
> > I should have also thought more, but I don't do this often enough to remember
> > all of the rules.  Sorry for the head ache.
> >
> > -Stafford
