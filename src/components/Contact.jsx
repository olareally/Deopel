function Contact() {
  return (
    <section className="section-block contact-block" id="contact">
      <div className="section-header">
        <span className="eyebrow">Get in Touch</span>
        <h2>Ready to start your training journey?</h2>
      </div>
      <div className="contact-grid">
        <div className="contact-card">
          <h3>Contact details</h3>
          <p>Phone: +234 800 123 4567</p>
          <p>Email: info@deopelengineering.com</p>
          <p>Location: Lagos, Nigeria</p>
        </div>
        <div className="contact-card contact-form">
          <h3>Send a message</h3>
          <form>
            <label>
              Name
              <input type="text" name="name" placeholder="Your name" />
            </label>
            <label>
              Email
              <input type="email" name="email" placeholder="you@example.com" />
            </label>
            <label>
              Message
              <textarea name="message" rows="4" placeholder="Tell us what training you need" />
            </label>
            <button type="submit" className="button primary-button">
              Send Inquiry
            </button>
          </form>
        </div>
      </div>
    </section>
  )
}

export default Contact
