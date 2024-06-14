import * as React from 'react';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createMaterialBottomTabNavigator } from '@react-navigation/material-bottom-tabs';

import HomePage from './view/pages/home/HomePage.tsx';
import SettingPage from './view/pages/setting/SettingPage.tsx';
import AboutPage from './view/pages/about/AboutPage.tsx';

import { Icon } from 'react-native-paper';
import PostDetail from './view/pages/home/PostDetail.tsx';

const Tab = createMaterialBottomTabNavigator();

function Index() {
    return (
        <Tab.Navigator>
            <Tab.Screen
                name="HomePage"
                component={HomePage}
                options={{
                    tabBarLabel: 'Home',
                    tabBarIcon: ({ color }) => <Icon source="home" color={color} size={26} />,
                }}
            />
            <Tab.Screen
                name="SettingPage"
                component={SettingPage}
                options={{
                    tabBarLabel: 'Setting',
                    tabBarIcon: ({ color }) => <Icon source="cog" color={color} size={26} />,
                }}
            />
            <Tab.Screen
                name="AboutPage"
                component={AboutPage}
                options={{
                    tabBarLabel: 'About',
                    tabBarIcon: ({ color }) => <Icon source="information" color={color} size={26} />,
                }}
            />
        </Tab.Navigator>
    );
}

const Stack = createNativeStackNavigator();

export default () => {
    return (
        <SafeAreaProvider>
            <NavigationContainer>
                <Stack.Navigator initialRouteName="Index">
                    <Stack.Screen name="Index" component={Index} options={{ headerShown: false }} />
                    <Stack.Screen name="PostDetail" component={PostDetail} />
                </Stack.Navigator>
            </NavigationContainer>
        </SafeAreaProvider>
    );
};

