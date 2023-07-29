<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Basic - SB UI Kit Pro</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="/sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/assets/img/favicon.png" />
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <div id="layoutDefault">
            <div id="layoutDefault_content">
                <main>
                    <!-- Navbar-->
                    <nav class="navbar navbar-marketing navbar-expand-lg bg-white navbar-light">
                        <div class="container px-5">
                            <a class="navbar-brand text-dark" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/index.html">SB UI Kit Pro</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i data-feather="menu"></i></button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav ms-auto me-lg-5">
                                    <li class="nav-item"><a class="nav-link" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/index.html">Home</a></li>
                                    <li class="nav-item dropdown dropdown-xl no-caret">
                                        <a class="nav-link dropdown-toggle" id="navbarDropdownDemos" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Landings
                                            <i class="fas fa-chevron-right dropdown-arrow"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end animated--fade-in-up me-lg-n25 me-xl-n15" aria-labelledby="navbarDropdownDemos">
                                            <div class="row g-0">
                                                <div class="col-lg-5 p-lg-3 bg-img-cover overlay overlay-primary overlay-70 d-none d-lg-block" style="background-image: url('../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/assets/img/backgrounds/bg-dropdown-xl.jpg')">
                                                    <div class="d-flex h-100 w-100 align-items-center justify-content-center">
                                                        <div class="text-white text-center z-1">
                                                            <div class="mb-3">Multipurpose landing pages for a variety of projects.</div>
                                                            <a class="btn btn-white btn-sm text-primary fw-500" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/index.html">View All</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-7 p-lg-5">
                                                    <div class="row">
                                                        <div class="col-lg-6">
                                                            <h6 class="dropdown-header text-primary">Applications</h6>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-app-mobile.html">Mobile App</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-app-desktop.html">Desktop App</a>
                                                            <div class="dropdown-divider border-0"></div>
                                                            <h6 class="dropdown-header text-primary">Business</h6>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-multipurpose.html">Multipurpose</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-agency.html">Agency</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-press.html">Press</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-directory.html">Directory</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-rental.html">Rental</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-real-estate.html">Real Estate</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-classifieds.html">Classifieds</a>
                                                            <div class="dropdown-divider border-0"></div>
                                                            <h6 class="dropdown-header text-primary">Lead Generation</h6>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-lead-capture.html">Lead Capture</a>
                                                            <div class="dropdown-divider border-0 d-lg-none"></div>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <h6 class="dropdown-header text-primary">Personal</h6>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-resume.html">Resume</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/landing-portfolio.html">Portfolio</a>
                                                            <div class="dropdown-divider border-0"></div>
                                                            <h6 class="dropdown-header text-primary">Header Styles</h6>
                                                            <a class="dropdown-item" href="header-basic.jsp">Basic</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-basic-signup.html">Basic (Signup)</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-graphic.html">Graphic</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-graphic-signup.html">Graphic (Signup)</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-video.html">
                                                                Video Header
                                                                <span class="badge bg-primary-soft text-primary ms-1">New!</span>
                                                            </a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-inner-page.html">Inner Page</a>
                                                            <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/header-nav-only.html">Nav Only</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="nav-item dropdown dropdown-xl no-caret">
                                        <a class="nav-link dropdown-toggle" id="navbarDropdownPages" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Pages
                                            <i class="fas fa-chevron-right dropdown-arrow"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end me-lg-n20 me-xl-n15 animated--fade-in-up" aria-labelledby="navbarDropdownPages">
                                            <div class="row g-0">
                                                <div class="col-lg-4 p-lg-5">
                                                    <h6 class="dropdown-header text-primary">Company</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-basic.html">Basic Page</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-company-about.html">About</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-company-pricing.html">Pricing</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-company-contact.html">Contact</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-company-team.html">Team</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-company-terms.html">Terms</a>
                                                    <div class="dropdown-divider border-0"></div>
                                                    <h6 class="dropdown-header text-primary">Support</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-help-center.html">Help Center</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-help-knowledgebase.html">Knowledgebase</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-help-message-center.html">Message Center</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-help-support-ticket.html">Support Ticket</a>
                                                    <div class="dropdown-divider border-0 d-lg-none"></div>
                                                </div>
                                                <div class="col-lg-4 p-lg-5">
                                                    <h6 class="dropdown-header text-primary">Careers</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-careers-overview.html">Careers List</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-careers-listing.html">Position Details</a>
                                                    <div class="dropdown-divider border-0"></div>
                                                    <h6 class="dropdown-header text-primary">Blog</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-blog-overview.html">Overview</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-blog-post.html">Post</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-blog-archive.html">Archive</a>
                                                    <div class="dropdown-divider border-0"></div>
                                                    <h6 class="dropdown-header text-primary">Portfolio</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-portfolio-grid.html">Grid</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-portfolio-large-grid.html">Large Grid</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-portfolio-masonry.html">Masonry</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-portfolio-case-study.html">Case Study</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-portfolio-project.html">Project</a>
                                                    <div class="dropdown-divider border-0 d-lg-none"></div>
                                                </div>
                                                <div class="col-lg-4 p-lg-5">
                                                    <h6 class="dropdown-header text-primary">Error</h6>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-400.html">400 Error</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-401.html">401 Error</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-404-1.html">404 Error (Option 1)</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-404-2.html">404 Error (Option 2)</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-500.html">500 Error</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-503.html">503 Error</a>
                                                    <a class="dropdown-item" href="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/page-error-504.html">504 Error</a>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="nav-item dropdown no-caret">
                                        <a class="nav-link dropdown-toggle" id="navbarDropdownDocs" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Documentation
                                            <i class="fas fa-chevron-right dropdown-arrow"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end animated--fade-in-up" aria-labelledby="navbarDropdownDocs">
                                            <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/quickstart" target="_blank">
                                                <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="book-open"></i></div>
                                                <div>
                                                    <div class="small text-gray-500">Documentation</div>
                                                    Usage instructions and reference
                                                </div>
                                            </a>
                                            <div class="dropdown-divider m-0"></div>
                                            <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/components" target="_blank">
                                                <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="code"></i></div>
                                                <div>
                                                    <div class="small text-gray-500">Components</div>
                                                    Code snippets and reference
                                                </div>
                                            </a>
                                            <div class="dropdown-divider m-0"></div>
                                            <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-ui-kit-pro/changelog" target="_blank">
                                                <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="file-text"></i></div>
                                                <div>
                                                    <div class="small text-gray-500">Changelog</div>
                                                    Updates and changes
                                                </div>
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                                <a class="btn fw-500 ms-lg-4 btn-teal" href="https://shop.startbootstrap.com/sb-ui-kit-pro">
                                    Buy Now
                                    <i class="ms-2" data-feather="arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </nav>
                    <!-- Page Header-->
                    <header class="page-header-ui page-header-ui-dark bg-gradient-primary-to-secondary">
                        <div class="page-header-ui-content">
                            <div class="container px-5">
                                <div class="row gx-5 justify-content-center">
                                    <div class="col-xl-8 col-lg-10 text-center">
                                        <h1 class="page-header-ui-title">Build your next project faster</h1>
                                        <p class="page-header-ui-text mb-5">Welcome to SB UI Kit Pro, a toolkit for building beautiful web interfaces, created by the development team at Start Bootstrap</p>
                                        <a class="btn fw-500 btn-teal me-2" href="#!">
                                            Get Started
                                            <i class="ms-2" data-feather="arrow-right"></i>
                                        </a>
                                        <a class="btn btn-link fw-500" href="#!">Learn More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="svg-border-angled text-white">
                            <!-- Angled SVG Border-->
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" fill="currentColor"><polygon points="0,100 100,0 100,100"></polygon></svg>
                        </div>
                    </header>
                    <section class="bg-white py-10">
                        <div class="container px-5">
                            <div class="row gx-5 text-center">
                                <div class="col-lg-4 mb-5 mb-lg-0">
                                    <div class="icon-stack icon-stack-xl bg-gradient-primary-to-secondary text-white mb-4"><i data-feather="layers"></i></div>
                                    <h3>Built for developers</h3>
                                    <p class="mb-0">Our modular, block-based build system makes building your next project fast and easy!</p>
                                </div>
                                <div class="col-lg-4 mb-5 mb-lg-0">
                                    <div class="icon-stack icon-stack-xl bg-gradient-primary-to-secondary text-white mb-4"><i data-feather="smartphone"></i></div>
                                    <h3>Modern responsive design</h3>
                                    <p class="mb-0">This UI Kit is build mobile-first, meaning it is will function beautifully on any device!</p>
                                </div>
                                <div class="col-lg-4">
                                    <div class="icon-stack icon-stack-xl bg-gradient-primary-to-secondary text-white mb-4"><i data-feather="code"></i></div>
                                    <h3>Complete documentation</h3>
                                    <p class="mb-0">All of the layouts, page sections, components, and utilities are fully covered in this products docs.</p>
                                </div>
                            </div>
                        </div>
                        <div class="svg-border-angled text-dark">
                            <!-- Angled SVG Border-->
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none" fill="currentColor"><polygon points="0,100 100,0 100,100"></polygon></svg>
                        </div>
                    </section>
                </main>
            </div>
            <div id="layoutDefault_footer">
                <footer class="footer pt-10 pb-5 mt-auto bg-dark footer-dark">
                    <div class="container px-5">
                        <div class="row gx-5">
                            <div class="col-lg-3">
                                <div class="footer-brand">SB UI Kit Pro</div>
                                <div class="mb-3">Design made easy</div>
                                <div class="icon-list-social mb-5">
                                    <a class="icon-list-social-link" href="#!"><i class="fab fa-instagram"></i></a>
                                    <a class="icon-list-social-link" href="#!"><i class="fab fa-facebook"></i></a>
                                    <a class="icon-list-social-link" href="#!"><i class="fab fa-github"></i></a>
                                    <a class="icon-list-social-link" href="#!"><i class="fab fa-twitter"></i></a>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="row gx-5">
                                    <div class="col-lg-3 col-md-6 mb-5 mb-lg-0">
                                        <div class="text-uppercase-expanded text-xs mb-4">Product</div>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2"><a href="#!">Landing</a></li>
                                            <li class="mb-2"><a href="#!">Pages</a></li>
                                            <li class="mb-2"><a href="#!">Sections</a></li>
                                            <li class="mb-2"><a href="#!">Documentation</a></li>
                                            <li><a href="#!">Changelog</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-5 mb-lg-0">
                                        <div class="text-uppercase-expanded text-xs mb-4">Technical</div>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2"><a href="#!">Documentation</a></li>
                                            <li class="mb-2"><a href="#!">Changelog</a></li>
                                            <li class="mb-2"><a href="#!">Theme Customizer</a></li>
                                            <li><a href="#!">UI Kit</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-5 mb-md-0">
                                        <div class="text-uppercase-expanded text-xs mb-4">Includes</div>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2"><a href="#!">Utilities</a></li>
                                            <li class="mb-2"><a href="#!">Components</a></li>
                                            <li class="mb-2"><a href="#!">Layouts</a></li>
                                            <li class="mb-2"><a href="#!">Code Samples</a></li>
                                            <li class="mb-2"><a href="#!">Products</a></li>
                                            <li class="mb-2"><a href="#!">Affiliates</a></li>
                                            <li><a href="#!">Updates</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="text-uppercase-expanded text-xs mb-4">Legal</div>
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2"><a href="#!">Privacy Policy</a></li>
                                            <li class="mb-2"><a href="#!">Terms and Conditions</a></li>
                                            <li><a href="#!">License</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="my-5" />
                        <div class="row gx-5 align-items-center">
                            <div class="col-md-6 small">Copyright &copy; Your Website 2023</div>
                            <div class="col-md-6 text-md-end small">
                                <a href="#!">Privacy Policy</a>
                                &middot;
                                <a href="#!">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../../../../../../../../sb-ui-kit-pro-2.0.5_no-source/sb-ui-kit-pro_no-source/dist/js/scripts.js"></script>
    </body>
</html>
