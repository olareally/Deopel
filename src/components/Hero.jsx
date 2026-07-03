import { Link } from 'react-router-dom'
import logo from '../assets/deopel-logo.png'

function Hero() {
  return (
    <section className="hero-section">
      <div className="hero-logo-wrap">
        <img src={logo} alt="Deopel logo" className="hero-logo" />
      </div>
      <div className="hero-copy">
        <span className="eyebrow">Capacity Building</span>
        <h1>Training young talent for artisanship, engineering, and professional success.</h1>
        <p>
          Deopel Engineering Associates Limited empowers school leavers, graduates,
          and professionals through practical training, certification support, and
          placement collaborations across engineering and artisan skills.
        </p>
        <div className="hero-actions">
          <Link to="/contact" className="button primary-button">
            Start a Program
          </Link>
          <Link to="/what" className="button secondary-button">
            Explore What We Do
          </Link>
        </div>
      </div>
      <div className="hero-panel">
        <div className="hero-card">
          <h2>Self-sustainability focus</h2>
          <p>
            We help graduates become self-employed, self-reliant and ready to grow
            careers in multiple industries.
          </p>
        </div>
        <div className="hero-card accent-card">
          <h2>Certification and placement</h2>
          <p>
            Training is delivered with partner workshops and recognized credentials
            for stronger employability.
          </p>
        </div>
      </div>
    </section>
  )
}

export default Hero
