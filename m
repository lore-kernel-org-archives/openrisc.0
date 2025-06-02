Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381C19049A
	for <linux-openrisc@vger.kernel.org>; Mon,  2 Jun 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858786; cv=none; b=phDiD/2JEKBSz2UOMRAek5WCwPu3YfF3WuLVh6UfdnWaYPP/F/TvtewlVcnxiKCF4jQIWGtdzkY6ZOFt+allq/pavNi8C+F32stmYc17oJ6OBAeJkx8H7GH0ob3sew6sjbHenMpC+6iuWkCCRyUUmQ5nDJxbMmjGmERPW0xBHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858786; c=relaxed/simple;
	bh=NrRseK9qTC4HGnJ1GzmGF/h3zbHKtdYFfpW3V4golNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwHLdK/dJ/LlIhAL+hw+xcot/SigXwr+XdDqf5t+LxZoI0bkTUT1adF83wTRtkUuhjYVLrSVc/ykISKCHOR26LTPso06VE/aBmLnGUqm3EElnYsi4nn64g/3jwjL9DR2KV5EZPyeS+2tdAxte81Mo6fs4Zcl4xjvmWXljs76fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAWbgshi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAWbgshi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so48591965e9.2
        for <linux-openrisc@vger.kernel.org>; Mon, 02 Jun 2025 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858783; x=1749463583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zPzXnboEcEHU89lLmH1ctS6hwrgRdBknijK3EtppsI=;
        b=QAWbgshi9Qd+MV2Zw2W7NxMHs5qNi/yzwVmw/Ju7MMnOyrxdHrZ6/ULi7QJeIr5qCh
         J5OD4RDPFtOHorfevdEqNpNMVtEQKR6RcB19zA8sjDNkAgzxTX1AO4kcyhj3cWRH43CI
         TLd+9Ta4HbBT6eae4GVUNMs9r7hsx6raMjKLyPJ/RN95sgkHvwKVrNq3c26LLa3NWQbR
         t2bfJ3UzNsn2b9rAtzuQeq+yBTeMy/Eu75kWi8Yg2Wrorub9FNbAWhQfuOwl5VXmxbDs
         SsCs7qTdN5D61L7xh/g3P0mQLoZuc+LV5afWdYsbBy5MAeGivp0aWzZVHFa7GySghjPU
         MqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858783; x=1749463583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zPzXnboEcEHU89lLmH1ctS6hwrgRdBknijK3EtppsI=;
        b=o1qo6IHc7W/9JERnI12htQMSj9TbENG44d6gRoe5pu1cX5Py2euYMTQCDyF/N2WZh/
         c2DIL0bqWCDgUNmUOuNJWdIJe0Kwsb3Zz42a51rorIfl7v7muaQ78SpWjBTXHYB1oOJt
         E5QYmJ4qjX47DTlBCfd9qByvaXEY32RDAFnwJ25pioTTgCMJiIGk0jsA4ov4QecNZ2dt
         on6dW8iGGGx74vWYdlTG1yyd6bEoOfA03ullWiuZaqPZx8AuKvABQ7SuBdZtVKbvPp1Y
         fXHy6PF0yMDJ+G/1luJn1AShHqw+w8zAlIpbXwoA8M38DLZSeeopmg+mS1lDmaiN0ktA
         YEDg==
X-Forwarded-Encrypted: i=1; AJvYcCXZvqwvn3BoG0mqSxkgwf+fVP08XMfc0F8t98EVehYbNCjI17rsrXdpTgSutxpjo+BaYuxX6kvzWLSeNBpwfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fSm45UA6SfvuWOnlLU+vTCQ3X4ctYtdEa/RrhELAv09ZSrlu
	1K+tSvNAAU1Dl/NWcVQkDbPYNoporuJ/44D2iT7Uza8Qt/Vnp1MdorApC0eBSvolJzY=
X-Gm-Gg: ASbGnctser6+kbtiXm1dwSZG2eEJEy32cmVKYy9Sj6djhPuV3N5oiWCqIjmjRfM1I7r
	/0UlllWioURiEX5CfX36/HBGyfsQAnJq0BpLpygttWF+Mn46eiQ6qau6juSoyKTFN9w5+joGHA/
	1hXJfMG5O7p5si4v7WWL5FzG1wB1Cc+GKhbluSVkveJRZkwT/w5CQcNz+ZGG96VN4yFiQJp0gde
	GfMfj1JBMoKUxRwhEFjPA33LKBoYa5vxZc6svPEmj3yyKfhMcRYdGlnqX99OYyYI89xeRj8oKsw
	pnWB20hbzUObbd/2dLFtyJ3ItQnPKH9KHwmcw3/xL+YCns7fFNpfDv5HChPV1bnerQVviwsz5dT
	dV4LvliwTIdYhSMIt89cDJJJYzw==
X-Google-Smtp-Source: AGHT+IFGizzAJ3E3B6+ajTtT8CldCqJY5NbLZoujs3zCdRDifHik1seJj/o+XwqDbeEjC9wXT4KPYg==
X-Received: by 2002:a05:600c:3504:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-45125cc48b3mr54161155e9.29.1748858783041;
        Mon, 02 Jun 2025 03:06:23 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0467sm116209705e9.19.2025.06.02.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:06:20 -0700 (PDT)
Date: Mon, 2 Jun 2025 11:06:19 +0100
From: Stafford Horne <shorne@gmail.com>
To: Jeff Law <jeffreyalaw@gmail.com>
Cc: GCC patches <gcc-patches@gcc.gnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: Fix struct return test
Message-ID: <aD13mzN_61fC4p_0@antec>
References: <20250531060321.3687859-1-shorne@gmail.com>
 <9cbd6d7f-c5d0-4825-9b06-e694d32cdecd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbd6d7f-c5d0-4825-9b06-e694d32cdecd@gmail.com>

On Sun, Jun 01, 2025 at 09:17:45PM -0600, Jeff Law wrote:
> 
> 
> On 5/31/25 12:03 AM, Stafford Horne wrote:
> > In or1k structs are returned from functions using the memory address
> > passed in r3.  In the current version of GCC the struct stores changed
> > from r11 (the return value) to r3 the incoming memory address.  Both of
> > are valid.
> > 
> > Adjust the test to match what GCC is producing now.
> > 
> > gcc/testsuite/ChangeLog:
> > 
> > 	* gcc.target/or1k/return-2.c: Fix test.
> Given you're the maintainer of this port it seems like you can self-approve
> and commit this and the long jump offset patch.

Hi Jeff,

Thanks for checking, I usually just like to send out patches to give myself a
bit of a cooling off period and allow anyone to spot obvious issues.

I have pushed these now.

-Stafford

