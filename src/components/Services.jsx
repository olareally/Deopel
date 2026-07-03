const services = [
  {
    title: 'Building Services & Artisan Skills',
    icon: '🛠️',
    description:
      'Electrical wiring, plumbing, refrigeration, welding, painting, tiling, scaffolding, and construction finishing skills for domestic and industrial facilities.'
  },
  {
    title: 'Oil & Gas Industry Skills',
    icon: '🛢️',
    description:
      'Process control, instrumentation, industrial electrical, firefighting, HSE, welding, NDT, crane and forklift operation, and heavy-duty maintenance.'
  },
  {
    title: 'Automobile Diagnostics & Maintenance',
    icon: '🚗',
    description:
      'Car diagnostics, engine maintenance, auto electrical systems, air conditioning, welding, panel beating, and paint spraying.'
  },
  {
    title: 'Engineering Design Capacity Building',
    icon: '📐',
    description:
      'Electrical, process control, mechanical, and civil/structural design training for job placement and self-employment.'
  },
  {
    title: 'Social & Event Coverage',
    icon: '🎥',
    description:
      'Sound engineering, cinematography, video recording, and content creation training for public and corporate events.'
  },
  {
    title: 'Agriculture & Entrepreneurship',
    icon: '🌾',
    description:
      'Cropping, animal husbandry, poultry, catering, confectionery, fashion design, and interior/exterior decoration training for sustainable businesses.'
  }
]

function Services() {
  return (
    <section className="section-block" id="services">
      <div className="section-header">
        <span className="eyebrow">What We Do</span>
        <h2>Practical capacity building across artisans, engineering, and industry skills</h2>
      </div>
      <div className="service-grid">
        {services.map((service) => (
          <article className="service-card" key={service.title}>
            <div className="service-card-heading">
              <span className="service-icon">{service.icon}</span>
              <h3>{service.title}</h3>
            </div>
            <p>{service.description}</p>
          </article>
        ))}
      </div>
    </section>
  )
}

export default Services
