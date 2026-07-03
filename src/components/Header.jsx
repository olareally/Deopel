import { useState, useRef, useEffect } from 'react'
import { Link } from 'react-router-dom'
import logo from '../assets/deopel-logo.png'

function Header() {
  const [isNavOpen, setIsNavOpen] = useState(false)
  const [isSubmenuOpen, setIsSubmenuOpen] = useState(false)
  const navRef = useRef(null)
  const menuRef = useRef(null)

  const closeMenu = () => {
    setIsNavOpen(false)
    setIsSubmenuOpen(false)
  }

  const toggleSubmenu = () => {
    setIsSubmenuOpen((open) => !open)
  }

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (
        navRef.current &&
        !navRef.current.contains(event.target) &&
        menuRef.current &&
        !menuRef.current.contains(event.target)
      ) {
        setIsSubmenuOpen(false)
        setIsNavOpen(false)
      }
    }

    document.addEventListener('click', handleClickOutside)
    return () => document.removeEventListener('click', handleClickOutside)
  }, [])

  return (
    <header className="site-header">
      <div className="brand">
        <img src={logo} alt="Deopel logo" className="brand-logo" />
        <div>
          <span>Deopel</span>
          <small>Engineering Associates Limited</small>
        </div>
      </div>

      <button
        ref={menuRef}
        type="button"
        className="menu-toggle"
        aria-expanded={isNavOpen}
        aria-label="Toggle navigation"
        onClick={() => setIsNavOpen((open) => !open)}
      >
        <span />
        <span />
        <span />
      </button>

      <nav ref={navRef} className={`site-nav${isNavOpen ? ' open' : ''}`}>
        <Link to="/" onClick={closeMenu}>
          Home
        </Link>

        <div className={`nav-group${isSubmenuOpen ? ' open' : ''}`}>
          <button
            type="button"
            className="nav-group-title"
            aria-expanded={isSubmenuOpen}
            onClick={toggleSubmenu}
          >
            Who We Are
            <span className="chevron" aria-hidden="true" />
          </button>
          <div className="dropdown-menu">
            <Link to="/about-us" onClick={closeMenu}>
              About Us
            </Link>
            <Link to="/mission" onClick={closeMenu}>
              Mission
            </Link>
            <Link to="/impact" onClick={closeMenu}>
              Our Impact
            </Link>
          </div>
        </div>

        <Link to="/what" onClick={closeMenu}>
          What We Do
        </Link>
        <Link to="/partners" onClick={closeMenu}>
          Partners
        </Link>
        <Link to="/clients" onClick={closeMenu}>
          Clients
        </Link>
        <Link to="/gallery" onClick={closeMenu}>
          Gallery
        </Link>
        <Link to="/contact" onClick={closeMenu}>
          Contact
        </Link>
      </nav>
    </header>
  )
}

export default Header
