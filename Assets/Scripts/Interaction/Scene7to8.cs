using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Scene7to8 : MonoBehaviour
{

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Cut Scene"){
        SceneManager.LoadScene(10);  
        Destroy(gameObject);
		}
      
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

