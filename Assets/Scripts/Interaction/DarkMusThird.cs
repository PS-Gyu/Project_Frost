using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DarkMusThird : MonoBehaviour
{
    public static bool thirdDial = false;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            if (!thirdDial)
            {
                thirdDial = true;
                
            }

        }
    }
}
