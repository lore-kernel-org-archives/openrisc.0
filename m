Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AC1DE4F3
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182929; cv=none; b=m96EnvvYpE7BcqLvs2/u8b9orKHCbdZRSlYU8/OD4CfvGIE+YQI5r4W7fhHlW9DjtTyLH9rUcSFqetYzFQZNtFRdLth3mzXLKHb0X4kAREkMJZ3dVxwCfRjBnj9sCaXzTw1kIThiUJRQUqxTyD7EgVEHbnMYipzlkL29kWluT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182929; c=relaxed/simple;
	bh=yp9MiTnxld2JpBY/Vd5m2w9EfRhOCNbA2AqKKePL/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnxH4wb4MnmWijtVNB/xLpROFR5+B/QWzWGRZ5abp57ZOQbGj2Rt00TsnaNS6tWIWKtsF0RINd9W7lG9yL1Wqnr7FMWxQs6J1BJcYWHloz+M78a1/L74s5LdLykzqFRJ+zfNB7ZIGV/UVOzpLeAbAxIh7KDENM7D3PGse0u0Mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbw1Sllk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbw1Sllk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436281c8a38so104812475e9.3
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736182924; x=1736787724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzgiNeRzd+fF+/mSmnW2EwNW8maWJXvZ4uZvCg+O0xM=;
        b=Dbw1SllkNyW2eAvwDLtACHlI+BSShy55iufbX/OievwRejmnAtaHaHzFT5RyTtgI0k
         xFa2rzh+mi1YvRrHcyiFdQansYhBgyAJOQ7LpXhaznRfzsMPwLTD7fTC5xFq0b7o0e44
         BtuITSIsfdBbvmREr6apb0iIr24dkOe6q9J8tPRaldwY3qOByfyGEWWUEdwmsUGVkuTP
         dg+V7KinegCkXIzAWo1bEfXElHonoYrP2ixn9tcAxKvUnPoWZMI27HyA6+IFuGmXmqa0
         LCJIraknlS2L+s2vMJzNlUHOtBiSH3V/kiejcgoBz08jZjM0otgh8cZ/MWab7Cue9qHM
         /wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736182924; x=1736787724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzgiNeRzd+fF+/mSmnW2EwNW8maWJXvZ4uZvCg+O0xM=;
        b=DhfYrlZrCMg1en3GKTQzAv67awRfPH1lMth8Rzgqq4TdzoK3gnYwyNrDMV/QdwyibF
         tMX8TUxJpIMj44GUF6YFqXipxm44/S9C/v/lGa3U5Uqh62uGzmy1ZdXHWRLSwANoH7uc
         XoeADeFTdrc8GR+FemWBcOhh9oWACBXsp/A/t178P98IXR8ZRpt3s2XPKSaEAHJvOpg+
         TaQOFcQsEzk8Ae1/uZcVXSYGKP2D0VpyQ7o/1Ww7ld4bSaez3B7wHtLcdQzcLBysUZCV
         R/cwFjzlZkCZGxEpUksHbxHKUV+NvYRT5oUT7+ty9G0GzMGR+wHk3AOGvvnWJddIT0/N
         rf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2Sdjl8HbQd5pdIxFdtX00n5lcSErPk63MWj39zTUsV6WlniorLTYJFdX+Bgb73OVKXfSU7uaudSs19VRSfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPllcBOxQdcD/YUAfBjfIAq3XARC0TH8ESjNikxZn2qSLx+lHK
	JEBeTMOd5IFKEOO1n6gU/VOEJxfobUziKfKZQiDbw35ROXh0m3VgWrA4BQ==
X-Gm-Gg: ASbGncvziW1w2jkKpm5P+L8wInbqs1Lkqr8J8nq6fQLXnm8EY9902tZ6uZtr/XCSl1b
	WzSnf612F1keI2LmsarzSB+v3YAxkjtxL40qfr2ATIAwumUeLP4VTKMC1zce5krFjaJqBZ6hkSU
	+bW7OTC0V1D9GvnZDmYYLRqWGyXzAm2LlmFxaBomneQfXrx7/+0IBO75Dwquaoaun0FoSWAWabT
	lsWgMmovGbGLCodtJtiVRo7lCTWL2TBt9IyDf4hzn6asKQwyC6Df0ExNmNQm1kEpEz3ERPBB9/m
	RbOqZJTINXviHeOaT/I/
X-Google-Smtp-Source: AGHT+IHgAdppx7waL0qbe0FeIOly+UuIScLZ9SXYV0oTsTa7UDmHhOwnMD01YQwRscTX1DHY9uA+5w==
X-Received: by 2002:a05:6000:188d:b0:385:f7d2:7e9b with SMTP id ffacd0b85a97d-38a221f3785mr46606270f8f.30.1736182924077;
        Mon, 06 Jan 2025 09:02:04 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828d39sm49858307f8f.9.2025.01.06.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:02:02 -0800 (PST)
Date: Mon, 6 Jan 2025 17:02:01 +0000
From: Stafford Horne <shorne@gmail.com>
To: Jeff Law <jeffreyalaw@gmail.com>
Cc: GCC patches <gcc-patches@gcc.gnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: add .note.GNU-stack section on linux
Message-ID: <Z3wMiWSBG7BJyYSv@antec>
References: <20250106130117.1230925-1-shorne@gmail.com>
 <3335b1e7-5488-4e4d-a313-3e989b2abd9f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3335b1e7-5488-4e4d-a313-3e989b2abd9f@gmail.com>

On Mon, Jan 06, 2025 at 07:37:56AM -0700, Jeff Law wrote:
> 
> 
> On 1/6/25 6:01 AM, Stafford Horne wrote:
> > In the OpenRISC build we get the following warning:
> > 
> >      ld: warning: __modsi3_s.o: missing .note.GNU-stack section implies executable stack
> >      ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > 
> > Fix this by adding a .note.GNU-stack to indicate the stack does not need to be
> > executable for the lib1funcs.
> > 
> > Note, this is also needed for the upcoming glibc 2.41.
> > 
> > libgcc/
> > 	* config/or1k/lib1funcs.S: Add .note.GNU-stack section on linux.
> OK for the trunk.  You've got write privs, correct?

Thanks,

Yes I should still have access.  Also, I would like to add to the release-14
branch.  Is there anything special I need to do to add the patch there?

-Stafford
