        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

        <!DOCTYPE html>
            <html>
                <head>
                    <title>Task Tracker - Login</title>
                    <meta charset="UTF-8"/>
                    <spring:url value="/css/loginStyle.css" var="jspcss"/>
                    <link rel="stylesheet" type="text/css" href="${jspcss}"/>
                </head>
                <body>
                    <div class="login-container">
                    <div class="glass-card">
                    <div class="logo-icon">
                         <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                         <polyline points="20 6 9 17 4 12"/>
                         </svg>
                    </div>

                        <h2>Task Tracker</h2>
                        <p>Sign in to your account</p>

                        <%
                        String error = request.getParameter("error");
                        %>

                        <% if (error != null) { %> <div class="error-message"> Invalid username or password. </div> <% } %>

                        <form action="/tracker/login" method="post" onsubmit="return handleSubmit()">

                        <div class="input-group">
                            <label for="username">Username</label>
                            <input type="text" name="username" id="username" required placeholder="Enter the username"
                            />
                            <span class="tick-icon" id="username-tick">
                             <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                                         stroke="#1D9E75" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="20 6 9 17 4 12"/>
                            </svg>
                        </span>
                        </div>

                        <div class="input-group"  style="position:relative">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" required placeholder="Enter the password"
                        onkeydown="if(event.key===' ') event.preventDefault()"/>
                        <button type="button" class="eye-btn" onclick="toggleEye()">
                        <svg id="eye-icon" width="18" height="18" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2"
                                     stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                    <circle cx="12" cy="12" r="3"/>
                        </svg>
                        </button>
                        </div>

                        <button type="submit">Login</button>

                        <div class="register-link">
                        <p>Don't have an account? <a href="/tracker/register">Register</a></p>
                        </div>
                        </form>
                    </div>
                    </div>

                    <script>
                    let eyeOpen= false;
                    function toggleEye()
                    {
                        eyeOpen = !eyeOpen;
                        const inp = document.getElementById('password');
                        inp.type = eyeOpen ? 'text' : 'password';
                       const icon = document.getElementById('eye-icon');
                                   icon.innerHTML = eyeOpen
                                       ? '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/>'
                                       : '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
                    }
                    function validateusername()
                    {
                        const val = document.getElementById('username').value.trim();
                        const inp = document.getElementById('username');
                        const err = document.getElementById('username-err');
                        const tick = document.getElementById('username-tick');

                        if(val =='')
                        {
                            inp.className = '';
                            err.textContent = '';
                            tick.style.display = 'none';
                            return false;
                        }
                        if(val.length <3)
                        {
                            inp.className = 'error';
                            err.textContent = 'username must be at least 3 characters';
                             tick.style.display = 'none';
                            return false;
                        }
                        if (!/^[a-zA-Z0-9_]+$/.test(val))
                        {
                            inp.className = 'error';
                            err.textContent = 'Only letters, numbers and _ allowed';
                             tick.style.display = 'none';
                            return false;
                        }
                        inp.className = 'success';
                        err.textContent = '';
                         tick.style.display = 'flex';
                        return true;
                    }

                    function validatePassword()
                    {
                        const val = document.getElementById('password').value;
                        const inp = document.getElementById('password');
                        const err = document.getElementById('password-err');
                        const bars = ['s1', 's2', 's3', 's4'].map(id => document.getElementById(id));
                        bars.forEach(b => b.style.background = 'rgba(255,255,255,0.1)');
                        if(val == '' )
                        {
                            err.textContent = '';
                            inp.className = '';
                            return false;
                        }
                        if(val.includes(' '))
                        {
                            inp.className = 'error';
                                err.textContent = 'Password cannot contain spaces';
                                 err.style.color = '#f87171';
                                return false;
                        }
                        let strength = 0;

                        if(val.length >=6)
                            strength++;

                        if( val.length >=10)
                            strength++;

                        if (/[A-Z]/.test(val) && /[0-9]/.test(val))
                            strength++;

                        if (/[^a-zA-Z0-9]/.test(val))
                            strength++;
                        const colors = ['#e24b4a','#f97316','#facc15','#1D9E75'];
                        const labels = ['Weak','Fair','Good','Strong'];

                        for(let i=0; i<strength; i++)
                            bars[i].style.background = colors[strength-1];

                        if (val.length < 6)
                        {
                            inp.className = 'error';
                            err.textContent = 'Password must be at least 6 characters';
                             err.style.color = '#f87171';
                            return false;
                        }
                        inp.className = 'success';
                        err.textContent = labels[strength - 1] || '';
                        err.style.color = colors[strength -1];
                        return true;
                    }

                    function handleSubmit()
                    {
                        const s = validateusername();
                        const b = validatePassword();

                        return s && b;
                    }
                    </script>
                </body>
            </html>




