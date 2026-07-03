import './App.css'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Header from './components/Header'
import Home from './pages/Home'
import Who from './pages/Who'
import What from './pages/What'
import ImpactPage from './pages/Impact'
import PartnersPage from './pages/Partners'
import ClientsPage from './pages/Clients'
import GalleryPage from './pages/Gallery'
import ContactPage from './pages/Contact'
import MissionPage from './pages/Mission'
import Footer from './components/Footer'

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <Header />
        <main>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about-us" element={<Who />} />
            <Route path="/mission" element={<MissionPage />} />
            <Route path="/what" element={<What />} />
            <Route path="/impact" element={<ImpactPage />} />
            <Route path="/partners" element={<PartnersPage />} />
            <Route path="/clients" element={<ClientsPage />} />
            <Route path="/gallery" element={<GalleryPage />} />
            <Route path="/contact" element={<ContactPage />} />
          </Routes>
        </main>
        <Footer />
      </div>
    </BrowserRouter>
  )
}

export default App
