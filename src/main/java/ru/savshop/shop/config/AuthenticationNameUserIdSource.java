package ru.savshop.shop.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.UserIdSource;

/**
 * Implementation of UserIdSource that returns the Spring Security {@link Authentication}'s name as the user ID.
 * @author Craig Walls
 */
public class AuthenticationNameUserIdSource implements UserIdSource {

	public String getUserId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			throw new IllegalStateException("Unable to get a ConnectionRepository: no user signed in");
		}
		return authentication.getName();
	}
	
}